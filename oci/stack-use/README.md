# Consume the published stack

This directory is the end-to-end consumer of:

```text
docker.io/denis256/terragrunt-oci-hello-stack:1.0.0
```

Terragrunt resolves the complete OCI source chain:

```text
stack-use/terragrunt.stack.hcl
  -> terragrunt-oci-hello-stack
     -> terragrunt-oci-hello-unit
        -> terragrunt-oci-hello-module
```

## Prerequisites

- Terragrunt v1.1.3 or newer
- OpenTofu
- Published module, unit, and stack artifacts

The remote stack generation and plan were validated on 2026-08-13 with
Terragrunt v1.1.3, the latest stable release, and OpenTofu v1.12.2.

## Generate and plan

All three artifacts must already exist. The published examples are public, so
login is not required for consumption.

```bash
cd /projects/gruntwork/terragrunt-tests/oci/stack-use
TG_EXPERIMENT=oci terragrunt stack generate --source-update
TG_EXPERIMENT=oci terragrunt stack run plan --source-update
```

Expected generated files include:

```text
.terragrunt-stack/hello/terragrunt.stack.hcl
.terragrunt-stack/hello/.terragrunt-stack/hello/terragrunt.hcl
.terragrunt-stack/hello/.terragrunt-stack/hello/terragrunt.values.hcl
```

Expected plan result:

```text
+ message = "Hello, OCI stack, from an OCI module!"

Run Summary  1 units
Succeeded    1
```

## Override the source

```bash
OCI_REGISTRY=docker.io \
OCI_NAMESPACE=denis256 \
OCI_VERSION=1.0.0 \
TG_EXPERIMENT=oci \
terragrunt stack run plan --source-update
```

Private artifacts require credentials discoverable through the normal Docker
credential configuration. Use `docker login REGISTRY` before running
Terragrunt.

## Cleanup

```bash
terragrunt stack clean
```

Generated `.terragrunt-stack` content is ignored by Git and must not be committed.

## What to read next

- [Publish the stack source](../stack-publish/README.md)
- [Full OCI example](../README.md)
