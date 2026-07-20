#!/usr/bin/env bash
# Stop the registry and remove generated artifacts and caches.
source "$(dirname "$0")/00-env.sh"

docker rm -f "$REGISTRY_NAME" >/dev/null 2>&1 || true
rm -rf "$E2E_DIR/cas-work" "$E2E_DIR/cas-evidence-work" "$E2E_DIR/.terragrunt-cache" "$E2E_DIR/subdir-test/.terragrunt-cache" \
  "$E2E_DIR"/module.zip "$E2E_DIR"/config.json "$E2E_DIR"/manifest.json "$E2E_DIR"/manifest.digest
log "cleaned up (certs, bin and logs kept)"
