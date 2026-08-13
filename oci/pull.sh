#!/usr/bin/env bash
set -euo pipefail

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

pull_and_validate() {
  local name="$1"
  local reference="$2"
  local archive_name="$3"
  local required_file="$4"
  local output_dir="$pull_dir/$name"
  local manifest_file="$pull_dir/$name-manifest.json"

  mkdir -p "$output_dir"

  printf 'Pulling %s\n' "$reference"
  "$oras_bin" manifest fetch "$reference" >"$manifest_file"
  jq -e \
    --arg artifact_type "$artifact_type" \
    --arg layer_type "$layer_type" \
    '.artifactType == $artifact_type and (.layers | length == 1) and .layers[0].mediaType == $layer_type' \
    "$manifest_file" >/dev/null

  "$oras_bin" pull --output "$output_dir" "$reference"
  unzip -tq "$output_dir/$archive_name" >/dev/null
  unzip -Z1 "$output_dir/$archive_name" | grep -Fxq "$required_file"

  printf 'Validated %s\n' "$reference"
}

require_executable "$oras_bin"
require_executable jq
require_executable unzip

pull_dir="$(mktemp -d "${TMPDIR:-/tmp}/terragrunt-oci-pull.XXXXXX")"
readonly pull_dir
trap 'rm -rf -- "$pull_dir"' EXIT

pull_and_validate module "$module_ref" module.zip main.tf
pull_and_validate unit "$unit_ref" unit.zip terragrunt.hcl
pull_and_validate stack "$stack_ref" stack.zip terragrunt.stack.hcl
