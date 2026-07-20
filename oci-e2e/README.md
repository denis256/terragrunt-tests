# OCI module sources + CAS: full end-to-end example

A complete, self-contained example that publishes an OpenTofu module to a real OCI
registry and downloads it with Terragrunt, then proves the layer is cached in Content
Addressable Storage (CAS). Everything runs locally against a Docker `registry:2` over
TLS. No cloud credentials, no external network.

## Contents

| File | Purpose |
|---|---|
| `run-all.sh` | The whole flow: registry -> push -> build -> download -> CAS checks. |
| `00-env.sh` | Shared config (registry name/port, paths, logging). Sourced, not run. |
| `01-start-registry.sh` | Starts `registry:2.8.3` on `127.0.0.1:5443` with a self-signed TLS cert. |
| `02-push-module.sh` | Builds the module zip + OCI manifest, pushes via the Distribution API. |
| `03-run-terragrunt.sh` | Builds `terragrunt` from source and plans the root + `//subdir` fixtures. |
| `04-cas-validation.sh` | Asserts cold-fetch, warm-hit, and tag-repush cache behavior. |
| `05-cas-evidence.sh` | Prints and asserts the three signals that prove OCI uses CAS. |
| `99-cleanup.sh` | Stops the registry and removes generated artifacts and caches. |
| `CAS-EVIDENCE.md` | Reference: the three CAS signals in detail. |

## Prerequisites

- Docker (for the local registry).
- Go 1.26+ (the scripts build `terragrunt` from `/projects/gruntwork/terragrunt-2`;
  override with `TG_REPO=/path/to/terragrunt`).
- OpenTofu or Terraform on `PATH`.

## Quick start

```
cd /projects/gruntwork/terragrunt-tests/oci-e2e
./run-all.sh
```

Real output of a full run:

```
[18:41:56] registry registry:2.8.3 up on https://127.0.0.1:5443 (ping: 200)
[18:41:56] pushed blob sha256:6a0140f6...097564 (module.zip)
[18:41:56] pushed blob sha256:44136fa3...aaff8a (config.json)
[18:41:56] pushed manifest 1.0.0 (sha256:7da0ee0f...aea8b) to modules/vpc
[18:41:56] building terragrunt from /projects/gruntwork/terragrunt-2
[18:42:25] OK: /projects/.../oci-e2e produced: oci_works = "hello-from-docker-registry"
[18:42:26] OK: /projects/.../oci-e2e/subdir-test produced: sub = "sub"
[18:42:26] e2e PASSED
[18:42:26] OK: binary executes
[18:42:27] OK: cold run fetched the module (1 blob GET)
[18:42:27] OK: warm run served from CAS (zero blob GETs, tag re-probed)
[18:42:27] OK: re-pushed tag invalidated the cache and fetched the new content
[18:42:28] cas validation PASSED
[18:42:29] cas evidence PASSED: OCI layers are served from CAS on warm runs
```

Tear down with `./99-cleanup.sh`.

## The Terragrunt config

`terragrunt.hcl` names the module by its `oci://` URL. The host is the registry, the
path is the repository, and `tag` (or `digest`) selects the version:

```hcl
terraform {
  source = "oci://127.0.0.1:5443/modules/vpc?tag=1.0.0"
}
```

`subdir-test/terragrunt.hcl` selects a subdirectory of the same module with `//subdir`:

```hcl
terraform {
  source = "oci://127.0.0.1:5443/modules/vpc//subdir?tag=1.0.0"
}
```

## Running it by hand (one module, step by step)

If you want to drive a single download yourself instead of the scripts:

```
# 1. Registry + module (uses the scripts' helpers)
./01-start-registry.sh
./02-push-module.sh
./03-run-terragrunt.sh    # just builds ./bin/terragrunt and plans the fixtures

# 2. Plan any oci:// source. TLS trust comes from SSL_CERT_FILE; the oci
#    experiment must be enabled.
cd $(mktemp -d) && printf 'terraform {\n  source = "oci://127.0.0.1:5443/modules/vpc?tag=1.0.0"\n}\n' > terragrunt.hcl
SSL_CERT_FILE=/projects/gruntwork/terragrunt-tests/oci-e2e/certs/cert.pem \
  TG_EXPERIMENT=oci TG_NON_INTERACTIVE=true TG_LOG_LEVEL=debug \
  /projects/gruntwork/terragrunt-tests/oci-e2e/bin/terragrunt plan
```

Note the two flags that make `oci://` work:

- `TG_EXPERIMENT=oci` gates the feature. Without it, `oci://` sources fail with
  `error downloading 'oci://...'` and the CAS path is skipped entirely.
- `SSL_CERT_FILE=certs/cert.pem` trusts the registry's self-signed cert. The OCI getter
  is HTTPS-only, so a plain-HTTP `localhost:5000` registry will not work; a trusted cert
  is required.

## Proving the layer is cached in CAS

Run `./05-cas-evidence.sh`. It publishes unique content, does a cold then a warm plan,
and reports the three signals:

```
 cold: blob-GETs +1  tag-HEADs +2  CAS-objects +4
 warm: blob-GETs +0  tag-HEADs +1  CAS-objects +0
 OK: warm run downloaded ZERO layer bytes -> served from CAS
 OK: warm run re-resolved the tag once -> re-push safety preserved
```

- **Warm run, zero blob GETs**: the layer was served from `~/.cache/terragrunt/cas/store`,
  not the registry.
- **Warm run, one tag HEAD**: the tag is re-resolved every run, so a re-pushed tag
  invalidates the cache instead of serving stale content.
- **CAS objects appear on cold, none on warm**: the tree is stored once, keyed by its
  manifest digest.

See `CAS-EVIDENCE.md` for the full breakdown, including what a regression looks like.

## What the module is

`02-push-module.sh` builds a two-file OpenTofu module and pushes it as an OCI artifact
using the contract OpenTofu 1.10 consumes natively:

- artifact type `application/vnd.opentofu.modulepkg`, one `archive/zip` layer.
- `main.tf`: `output "oci_works" { value = "hello-from-docker-registry" }`
- `subdir/sub.tf`: `output "sub" { value = "sub" }`

The `oci_works` output value is stamped per push, so the tag-repush test can prove new
content actually replaced the cached copy.

## Logs

Everything is appended to `logs/e2e.log` as well as printed, so a failing run can be
inspected after the fact.
