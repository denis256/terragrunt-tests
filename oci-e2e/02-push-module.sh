#!/usr/bin/env bash
# Build the OpenTofu module artifact and push it via the OCI Distribution API.
source "$(dirname "$0")/00-env.sh"

eval "$(python3 - "$E2E_DIR" <<'PY'
import hashlib, io, json, sys, zipfile
d = sys.argv[1]
buf = io.BytesIO()
with zipfile.ZipFile(buf, 'w') as z:
    import os
    value = os.environ.get('MODULE_OUTPUT', 'hello-from-docker-registry')
    z.writestr('main.tf', 'output "oci_works" { value = "%s" }' % value)
    z.writestr('subdir/sub.tf', 'output "sub" { value = "sub" }')
layer = buf.getvalue()
config = b'{}'
def dg(b): return 'sha256:' + hashlib.sha256(b).hexdigest()
manifest = json.dumps({
    'schemaVersion': 2,
    'mediaType': 'application/vnd.oci.image.manifest.v1+json',
    'artifactType': 'application/vnd.opentofu.modulepkg',
    'config': {'mediaType': 'application/vnd.oci.empty.v1+json', 'digest': dg(config), 'size': len(config)},
    'layers': [{'mediaType': 'archive/zip', 'digest': dg(layer), 'size': len(layer)}],
}).encode()
open(f'{d}/module.zip', 'wb').write(layer)
open(f'{d}/config.json', 'wb').write(config)
open(f'{d}/manifest.json', 'wb').write(manifest)
print(f"LAYER_DIGEST={dg(layer)}"); print(f"CONFIG_DIGEST={dg(config)}"); print(f"MANIFEST_DIGEST={dg(manifest)}")
PY
)"

CURL=(curl -sf --cacert "$CERT_DIR/cert.pem")

push_blob() {
  local file="$1" digest="$2"
  local loc
  loc=$("${CURL[@]}" -X POST "https://$REGISTRY_ADDR/v2/$REPO_PATH/blobs/uploads/" -D - -o /dev/null | tr -d '\r' | awk 'tolower($1)=="location:" {print $2}')
  case "$loc" in /*) loc="https://$REGISTRY_ADDR$loc";; esac
  case "$loc" in *\?*) loc="$loc&digest=$digest";; *) loc="$loc?digest=$digest";; esac
  "${CURL[@]}" -X PUT "$loc" -H "Content-Type: application/octet-stream" --data-binary "@$file" -o /dev/null
  log "pushed blob $digest ($file)"
}

push_blob "$E2E_DIR/module.zip" "$LAYER_DIGEST"
push_blob "$E2E_DIR/config.json" "$CONFIG_DIGEST"

"${CURL[@]}" -X PUT "https://$REGISTRY_ADDR/v2/$REPO_PATH/manifests/1.0.0" \
  -H "Content-Type: application/vnd.oci.image.manifest.v1+json" \
  --data-binary "@$E2E_DIR/manifest.json" -o /dev/null
log "pushed manifest 1.0.0 ($MANIFEST_DIGEST) to $REPO_PATH"
echo "$MANIFEST_DIGEST" > "$E2E_DIR/manifest.digest"
