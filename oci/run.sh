#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly script_dir
readonly terragrunt_bin="${TERRAGRUNT_BIN:-terragrunt}"

if ! command -v "$terragrunt_bin" >/dev/null 2>&1; then
  printf 'Required executable not found: %s\n' "$terragrunt_bin" >&2
  exit 1
fi

if ! command -v "${TG_TF_PATH:-tofu}" >/dev/null 2>&1; then
  printf 'Required executable not found: %s\n' "${TG_TF_PATH:-tofu}" >&2
  exit 1
fi

export TG_EXPERIMENT=oci
export TG_NON_INTERACTIVE=true
export TG_NO_COLOR=true

printf 'Planning the OCI module source\n'
(cd "$script_dir/module-use" && "$terragrunt_bin" run --source-update -- plan)

printf 'Generating the OCI stack source\n'
(cd "$script_dir/stack-use" && "$terragrunt_bin" stack generate --source-update)

printf 'Planning the generated OCI stack\n'
(cd "$script_dir/stack-use" && "$terragrunt_bin" stack run plan --source-update)
