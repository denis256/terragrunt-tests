# Docker Hub OCI source examples

This example publishes and consumes a small OpenTofu module and a Terragrunt
stack as OCI artifacts in the `denis256` Docker Hub namespace.

The artifacts are generic OCI artifacts, not container images. Use ORAS to push
and pull them. Terragrunt uses the same Docker credential configuration for
authenticated source downloads.

## Layout

| Directory | Purpose |
|---|---|
| [`module-publish/`](module-publish/README.md) | OpenTofu module packaged and published as OCI. |
| [`module-use/`](module-use/README.md) | Terragrunt configuration that uses the module through `terraform.source` and is published as a reusable unit. |
| [`stack-publish/`](stack-publish/README.md) | Terragrunt stack packaged and published as OCI. |
| [`stack-use/`](stack-use/README.md) | Terragrunt configuration that uses the stack through `stack.source`. |

The default artifacts are:

- `docker.io/denis256/terragrunt-oci-hello-module:1.0.0`
- `docker.io/denis256/terragrunt-oci-hello-unit:1.0.0`
- `docker.io/denis256/terragrunt-oci-hello-stack:1.0.0`

## Prerequisites

- Terragrunt v1.1.3 or newer
- OpenTofu
- ORAS
- Docker CLI
- `zip`, `unzip`, and `jq`

OCI source support is experimental in v1.1.3. The scripts enable the `oci`
experiment automatically.

## Validated versions

This exact flow was validated on 2026-08-13 with:

- Terragrunt v1.1.3, the latest stable release
- OpenTofu v1.12.2
- ORAS v1.3.3

The official Terragrunt Linux amd64 binary matched the v1.1.3 release
`SHA256SUMS` before validation.

## Login

Authenticate once with the Docker CLI. Enter a Docker Hub personal access token
when prompted:

```bash
docker login --username denis256
```

Neither the scripts nor Terragrunt print or copy the stored credential.

## Publish

Publish the versioned module, unit, and stack source archives:

```bash
./publish.sh
```

Each archive is pushed as an OCI image manifest with artifact type
`application/vnd.opentofu.modulepkg` and one `archive/zip` layer.

## Pull and validate

Pull all three artifacts with ORAS and validate their manifests and archive roots:

```bash
./pull.sh
```

## Consume with Terragrunt

Plan the module source, generate the remote stack, and plan its generated unit:

```bash
./run.sh
```

The expected module messages are:

```text
Hello, Docker Hub, from an OCI module!
Hello, OCI stack, from an OCI module!
```

You can also run each consumer directly:

```bash
cd module-use
TG_EXPERIMENT=oci terragrunt run --source-update -- plan

cd ../stack-use
TG_EXPERIMENT=oci terragrunt stack generate --source-update
TG_EXPERIMENT=oci terragrunt stack run plan --source-update
```

## Overrides

The defaults can be changed without editing the examples:

```bash
OCI_REGISTRY=docker.io \
OCI_NAMESPACE=denis256 \
OCI_VERSION=1.0.0 \
ORAS_BIN=oras \
TERRAGRUNT_BIN=terragrunt \
./run.sh
```

Use the same `OCI_REGISTRY`, `OCI_NAMESPACE`, and `OCI_VERSION` values for
publish, pull, and run.
