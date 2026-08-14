# Consume the module and publish the unit

This directory performs two jobs:

1. `terragrunt.hcl` consumes the published hello-world module through
   `terraform.source`.
2. The same file is packaged as the reusable unit artifact used by the published
   stack.

The unit artifact is:

```text
docker.io/denis256/terragrunt-oci-hello-unit:1.0.0
```

The module dependency is:

```text
oci://docker.io/denis256/terragrunt-oci-hello-module?tag=1.0.0
```

## Prerequisites

- Terragrunt v1.1.3 or newer
- OpenTofu
- Published `terragrunt-oci-hello-module` artifact

This flow was validated on 2026-08-13 with Terragrunt v1.1.3, the latest stable
release, and OpenTofu v1.12.2.

## Run the consumer

The module artifact must already exist. Public Docker Hub pulls do not require login.

```bash
cd /projects/gruntwork/terragrunt-tests/oci/module-use
TG_EXPERIMENT=oci terragrunt run --source-update -- plan
```

Expected plan output:

```text
Changes to Outputs:
  + message = "Hello, Docker Hub, from an OCI module!"
```

OCI source support is experimental in Terragrunt v1.1.3, so
`TG_EXPERIMENT=oci` is required. Keep `--source-update` when validating a
republished tag.

## Override the source

```bash
OCI_REGISTRY=docker.io \
OCI_NAMESPACE=denis256 \
OCI_VERSION=1.0.0 \
TG_EXPERIMENT=oci \
terragrunt run --source-update -- plan
```

Run the command from this directory. Options after `--` are passed to OpenTofu.

## Publish this unit

The root publication script packages `terragrunt.hcl` at the ZIP root and
publishes the module, unit, and stack with the same version:

```bash
cd ..
docker login --username denis256
OCI_VERSION=1.0.0 ./publish.sh
```

The stack passes `values.name` into this reusable unit. Direct module use falls
back to `Docker Hub`.

## Cleanup

The generated `.terragrunt-cache` directory is ignored by Git and can be removed
after the plan:

```bash
rm -rf .terragrunt-cache
```

## What to read next

- [Publish and test the stack](../stack-publish/README.md)
- [Full OCI example](../README.md)
