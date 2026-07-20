#!/usr/bin/env bash
# Start a TLS docker registry on 127.0.0.1:5443 with a self-signed cert.
source "$(dirname "$0")/00-env.sh"

mkdir -p "$CERT_DIR"
if [ ! -f "$CERT_DIR/cert.pem" ]; then
  openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:prime256v1 \
    -keyout "$CERT_DIR/key.pem" -out "$CERT_DIR/cert.pem" -days 30 -nodes \
    -subj "/CN=oci-e2e" -addext "subjectAltName=IP:127.0.0.1" 2>/dev/null
  log "generated self-signed cert in $CERT_DIR"
fi

docker rm -f "$REGISTRY_NAME" >/dev/null 2>&1 || true
docker run -d --name "$REGISTRY_NAME" -p "$REGISTRY_ADDR:5000" \
  -v "$CERT_DIR:/certs:ro" \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/cert.pem \
  -e REGISTRY_HTTP_TLS_KEY=/certs/key.pem \
  "$REGISTRY_IMAGE" >/dev/null

for _ in $(seq 1 15); do
  code=$(curl -s --cacert "$CERT_DIR/cert.pem" "https://$REGISTRY_ADDR/v2/" -o /dev/null -w "%{http_code}" || true)
  [ "$code" = "200" ] && break
  sleep 1
done
log "registry $REGISTRY_IMAGE up on https://$REGISTRY_ADDR (ping: $code)"
