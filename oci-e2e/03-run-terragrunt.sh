#!/usr/bin/env bash
# Build terragrunt from TG_REPO and plan both fixtures against the registry.
source "$(dirname "$0")/00-env.sh"

mkdir -p "$(dirname "$BIN")"
log "building terragrunt from $TG_REPO"
(cd "$TG_REPO" && go build -o "$BIN" .)

run_fixture() {
  local dir="$1" want="$2"
  rm -rf "$dir/.terragrunt-cache"
  log "plan in $dir"
  (cd "$dir" && SSL_CERT_FILE="$CERT_DIR/cert.pem" TG_EXPERIMENT=oci TG_NON_INTERACTIVE=true \
    "$BIN" plan 2>&1 | tee -a "$LOG_DIR/e2e.log" | grep -F "$want") \
    && log "OK: $dir produced: $want" \
    || { log "FAIL: $dir did not produce: $want"; exit 1; }
}

run_fixture "$E2E_DIR" 'oci_works = "hello-from-docker-registry"'
run_fixture "$E2E_DIR/subdir-test" 'sub = "sub"'
log "e2e PASSED"
