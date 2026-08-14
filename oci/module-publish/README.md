# Publish the hello-world module

This directory contains the OpenTofu module published as:

```text
docker.io/denis256/terragrunt-oci-hello-module:1.0.0
```

The module accepts `name` and returns a `message` output. It has no providers and
creates no infrastructure.

## Validated versions

This publication and pull flow was validated on 2026-08-13 with ORAS v1.3.3.
Its downstream module consumer was validated with Terragrunt v1.1.3, the latest
stable release, and OpenTofu v1.12.2.

## Prerequisites

- Docker CLI authenticated to Docker Hub as `denis256`
- Docker Hub personal access token with Read and Write permissions
- ORAS, `zip`, `unzip`, and `jq`

Authenticate without putting the token in shell history:

```bash
docker login --username denis256
```

Enter the personal access token when prompted.

## Publish

Run publication from the OCI example root:

```bash
cd /projects/gruntwork/terragrunt-tests/oci
OCI_VERSION=1.0.0 ./publish.sh
```

The script publishes the complete dependency chain in this order:

1. `terragrunt-oci-hello-module`
2. `terragrunt-oci-hello-unit`
3. `terragrunt-oci-hello-stack`

The module archive has `main.tf` at its root. The manifest uses artifact type
`application/vnd.opentofu.modulepkg` and exactly one `archive/zip` layer.

## Pull and validate

```bash
cd /projects/gruntwork/terragrunt-tests/oci
OCI_VERSION=1.0.0 ./pull.sh
```

`pull.sh` fetches the remote manifest and archive, validates the OCI media types,
checks the ZIP, and verifies that `main.tf` is at the archive root.

## Consume the module

```bash
cd ../module-use
TG_EXPERIMENT=oci terragrunt run --source-update -- plan
```

Expected output:

```text
+ message = "Hello, Docker Hub, from an OCI module!"
```

Use a new `OCI_VERSION` when changing source. If a tag is republished, consumers
need `--source-update` to refresh their source directories.

## What to read next

- [Consume and publish the reusable unit](../module-use/README.md)
- [Full OCI example](../README.md)
