#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly script_dir
readonly registry="${OCI_REGISTRY:-docker.io}"
readonly namespace="${OCI_NAMESPACE:-denis256}"
readonly version="${OCI_VERSION:-1.0.0}"
readonly oras_bin="${ORAS_BIN:-oras}"
readonly artifact_type="application/vnd.opentofu.modulepkg"
readonly layer_type="archive/zip"
readonly module_ref="${registry}/${namespace}/terragrunt-oci-hello-module:${version}"
readonly unit_ref="${registry}/${namespace}/terragrunt-oci-hello-unit:${version}"
readonly stack_ref="${registry}/${namespace}/terragrunt-oci-hello-stack:${version}"

require_executable() {
  local executable="$1"

  if ! command -v "$executable" >/dev/null 2>&1; then
    printf 'Required executable not found: %s\n' "$executable" >&2
    exit 1
  fi
}

require_executable "$oras_bin"
require_executable zip

publish_dir="$(mktemp -d "${TMPDIR:-/tmp}/terragrunt-oci-publish.XXXXXX")"
readonly publish_dir
trap 'rm -rf -- "$publish_dir"' EXIT

(cd "$script_dir/module-publish" && zip -X -q "$publish_dir/module.zip" main.tf)
(cd "$script_dir/module-use" && zip -X -q "$publish_dir/unit.zip" terragrunt.hcl)
(cd "$script_dir/stack-publish" && zip -X -q "$publish_dir/stack.zip" terragrunt.stack.hcl)

printf 'Publishing %s\n' "$module_ref"
(cd "$publish_dir" && "$oras_bin" push \
  --artifact-type "$artifact_type" \
  "$module_ref" \
  "module.zip:$layer_type")

printf 'Publishing %s\n' "$unit_ref"
(cd "$publish_dir" && "$oras_bin" push \
  --artifact-type "$artifact_type" \
  "$unit_ref" \
  "unit.zip:$layer_type")

printf 'Publishing %s\n' "$stack_ref"
(cd "$publish_dir" && "$oras_bin" push \
  --artifact-type "$artifact_type" \
  "$stack_ref" \
  "stack.zip:$layer_type")
