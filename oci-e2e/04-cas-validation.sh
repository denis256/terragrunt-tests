#!/usr/bin/env bash
# User test case: the built binary works and its CAS caching honors tag re-pushes.
# Requires 01 (registry), 02 (module pushed) and 03 (binary built) to have run.
source "$(dirname "$0")/00-env.sh"

log "build sanity: --version and --help must run"
"$BIN" --version >>"$LOG_DIR/e2e.log" 2>&1
"$BIN" --help >/dev/null 2>&1
log "OK: binary executes"

blob_gets() { docker logs "$REGISTRY_NAME" 2>&1 | grep -c "GET /v2/$REPO_PATH/blobs/" || true; }
tag_probes() { docker logs "$REGISTRY_NAME" 2>&1 | grep -c "HEAD /v2/$REPO_PATH/manifests/1.0.0" || true; }

WORK="$E2E_DIR/cas-work"
rm -rf "$WORK" && mkdir -p "$WORK"
cat > "$WORK/terragrunt.hcl" <<HCL
terraform {
  source = "oci://$REGISTRY_ADDR/$REPO_PATH?tag=1.0.0"
}
HCL

run_plan() {
  (cd "$WORK" && rm -rf .terragrunt-cache && \
    SSL_CERT_FILE="$CERT_DIR/cert.pem" TG_EXPERIMENT=oci TG_NON_INTERACTIVE=true \
    "$BIN" plan 2>&1 | tee -a "$LOG_DIR/e2e.log" | grep -F "$1" >/dev/null) \
    || { log "FAIL: plan output missing: $1"; exit 1; }
}

# Push unique content so this test starts cold even after 03 warmed the CAS store.
STAMP="$(date +%s)-$$"
log "pushing unique content for a cold start"
MODULE_OUTPUT="hello-cold-$STAMP" "$E2E_DIR/02-push-module.sh" >/dev/null

b0=$(blob_gets)
run_plan "oci_works = \"hello-cold-$STAMP\""
b1=$(blob_gets); h1=$(tag_probes)
[ $((b1 - b0)) -ge 1 ] || { log "FAIL: cold run downloaded no content"; exit 1; }
log "OK: cold run fetched the module ($((b1 - b0)) blob GET)"

run_plan "oci_works = \"hello-cold-$STAMP\""
b2=$(blob_gets); h2=$(tag_probes)
[ "$b2" -eq "$b1" ] || { log "FAIL: warm run re-downloaded content instead of using CAS"; exit 1; }
[ "$h2" -gt "$h1" ] || { log "FAIL: warm run did not re-probe the tag"; exit 1; }
log "OK: warm run served from CAS (zero blob GETs, tag re-probed)"

log "re-pushing tag 1.0.0 with new content"
MODULE_OUTPUT="hello-repush-$STAMP" "$E2E_DIR/02-push-module.sh" >/dev/null
run_plan "oci_works = \"hello-repush-$STAMP\""
b3=$(blob_gets)
[ "$b3" -gt "$b2" ] || { log "FAIL: re-pushed tag served a stale cache entry"; exit 1; }
log "OK: re-pushed tag invalidated the cache and fetched the new content"

# Restore the default module so the other fixtures stay consistent.
"$E2E_DIR/02-push-module.sh" >/dev/null

log "cas validation PASSED"
