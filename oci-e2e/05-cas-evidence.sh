#!/usr/bin/env bash
# Prints and asserts the three signals that prove OCI layers use CAS.
# See CAS-EVIDENCE.md. Requires 01 (registry), 02 (module), 03 (binary).
source "$(dirname "$0")/00-env.sh"

CAS_STORE="$HOME/.cache/terragrunt/cas/store"
blob_gets() { docker logs "$REGISTRY_NAME" 2>&1 | grep -c "GET /v2/$REPO_PATH/blobs/" || true; }
tag_heads() { docker logs "$REGISTRY_NAME" 2>&1 | grep -c "HEAD /v2/$REPO_PATH/manifests/1.0.0" || true; }
store_objs() { find "$CAS_STORE/blobs" "$CAS_STORE/trees" -type f 2>/dev/null | wc -l | tr -d ' '; }

# Push unique content so this run is a guaranteed cold start for its digest.
STAMP="$(date +%s)-$$"
log "publishing unique module content (cold start)"
MODULE_OUTPUT="cas-evidence-$STAMP" "$E2E_DIR/02-push-module.sh" >/dev/null

WORK="$E2E_DIR/cas-evidence-work"
rm -rf "$WORK" && mkdir -p "$WORK"
cat > "$WORK/terragrunt.hcl" <<HCL
terraform {
  source = "oci://$REGISTRY_ADDR/$REPO_PATH?tag=1.0.0"
}
HCL

plan() {
  ( cd "$WORK" && rm -rf .terragrunt-cache && \
    SSL_CERT_FILE="$CERT_DIR/cert.pem" TG_EXPERIMENT=oci TG_NON_INTERACTIVE=true TG_LOG_LEVEL=debug \
    "$BIN" plan 2>&1 | sed 's/\x1b\[[0-9;]*m//g' | tee -a "$LOG_DIR/e2e.log" )
}

echo "===================================================================="
echo " SIGNAL 1 + 2: cold run (digest not yet in CAS)"
echo "===================================================================="
b0=$(blob_gets); h0=$(tag_heads); o0=$(store_objs)
plan | grep -iE 'Downloading Terraform|CAS enabled|Successfully downloaded source using CAS'
b1=$(blob_gets); h1=$(tag_heads); o1=$(store_objs)
echo "--------------------------------------------------------------------"
echo " cold: blob-GETs +$((b1-b0))  tag-HEADs +$((h1-h0))  CAS-objects +$((o1-o0))"
[ $((b1-b0)) -ge 1 ] || { log "FAIL: cold run did not download the layer"; exit 1; }
[ $((o1-o0)) -ge 1 ] || { log "FAIL: cold run stored nothing in CAS"; exit 1; }

echo ""
echo "===================================================================="
echo " SIGNAL 2 + 3: warm run (same digest already in CAS)"
echo "===================================================================="
plan | grep -iE 'Downloading Terraform|CAS enabled|Successfully downloaded source using CAS'
b2=$(blob_gets); h2=$(tag_heads); o2=$(store_objs)
echo "--------------------------------------------------------------------"
echo " warm: blob-GETs +$((b2-b1))  tag-HEADs +$((h2-h1))  CAS-objects +$((o2-o1))"
[ "$b2" -eq "$b1" ] || { log "FAIL: warm run re-downloaded the layer (CAS not serving OCI)"; exit 1; }
echo " OK: warm run downloaded ZERO layer bytes -> served from CAS"
[ $((h2-h1)) -ge 1 ] || { log "FAIL: warm run did not re-resolve the tag (stale-tag risk)"; exit 1; }
echo " OK: warm run re-resolved the tag once -> re-push safety preserved"

echo ""
echo "===================================================================="
echo " CAS store on disk: $CAS_STORE"
echo "===================================================================="
du -sh "$CAS_STORE/blobs" "$CAS_STORE/trees" 2>/dev/null

rm -rf "$WORK"
# Restore the default module so other fixtures stay consistent.
"$E2E_DIR/02-push-module.sh" >/dev/null
log "cas evidence PASSED: OCI layers are served from CAS on warm runs"
