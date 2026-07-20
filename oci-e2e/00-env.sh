# Shared settings for the oci e2e scripts. Source, do not execute.
set -euo pipefail
E2E_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TG_REPO="${TG_REPO:-/projects/gruntwork/terragrunt-2}"
REGISTRY_NAME="oci-e2e-registry"
REGISTRY_ADDR="127.0.0.1:5443"
REGISTRY_IMAGE="registry:2.8.3"
REPO_PATH="modules/vpc"
CERT_DIR="$E2E_DIR/certs"
LOG_DIR="$E2E_DIR/logs"
BIN="$E2E_DIR/bin/terragrunt"
mkdir -p "$LOG_DIR"
log() { echo "[$(date +%H:%M:%S)] $*" | tee -a "$LOG_DIR/e2e.log"; }
