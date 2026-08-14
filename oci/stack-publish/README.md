# Publish the hello-world stack

This directory contains a Terragrunt stack source published as:

```text
docker.io/denis256/terragrunt-oci-hello-stack:1.0.0
```

The stack defines one `hello` unit sourced from:

```text
oci://docker.io/denis256/terragrunt-oci-hello-unit?tag=1.0.0
```

The unit then downloads the hello-world module. The dependency order is module,
unit, then stack.

## Prerequisites

- Terragrunt v1.1.3 or newer
- OpenTofu
- Published module and unit artifacts
- Docker Hub login, ORAS, and `zip` for publication

The local stack generation and plan were validated on 2026-08-13 with Terragrunt
v1.1.3, the latest stable release, and OpenTofu v1.12.2.

## Test the stack source locally

The module and unit artifacts must already exist. Public Docker Hub pulls do not
require login.

```bash
cd /projects/gruntwork/terragrunt-tests/oci/stack-publish
TG_EXPERIMENT=oci terragrunt stack generate --source-update
TG_EXPERIMENT=oci terragrunt stack run plan --source-update
```

Expected generated files include:

```text
.terragrunt-stack/hello/terragrunt.hcl
.terragrunt-stack/hello/terragrunt.values.hcl
```

Expected plan result:

```text
+ message = "Hello, OCI stack, from an OCI module!"

Run Summary  1 units
Succeeded    1
```

## Publish

Use the root script so all three artifacts use identical registry, namespace,
and version values:

```bash
cd ..
docker login --username denis256
OCI_VERSION=1.0.0 ./publish.sh
OCI_VERSION=1.0.0 ./pull.sh
```

The stack archive contains `terragrunt.stack.hcl` at its ZIP root. The manifest
uses artifact type `application/vnd.opentofu.modulepkg` and exactly one
`archive/zip` layer.

## Cleanup

```bash
terragrunt stack clean
```

Generated `.terragrunt-stack` content is ignored by Git and must not be committed.

## What to read next

- [Consume the published stack](../stack-use/README.md)
- [Full OCI example](../README.md)
