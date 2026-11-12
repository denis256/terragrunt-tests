#!/usr/bin/env bash
# Runs every outputs-block example and checks the expected output.
set -uo pipefail

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

if ! "$terragrunt_bin" --experiment outputs-block --version >/dev/null 2>&1; then
  printf '%s does not know the outputs-block experiment. Build terragrunt from the branch:\n' "$terragrunt_bin" >&2
  printf '  cd /projects/gruntwork/terragrunt-4 && go build -o terragrunt .\n' >&2
  printf '  TERRAGRUNT_BIN=/projects/gruntwork/terragrunt-4/terragrunt %s\n' "$0" >&2
  exit 1
fi

export TG_EXPERIMENT=outputs-block
export TG_NON_INTERACTIVE=true
export TG_NO_COLOR=true

pass=0
fail=0

# tg <dir> <args...>: runs terragrunt in <dir> and prints combined output.
tg() {
  local dir="$1"
  shift
  (cd "$script_dir/$dir" && "$terragrunt_bin" "$@" 2>&1)
}

# expect <name> <substring> <output>: PASS when output holds substring.
expect() {
  if grep -qF -- "$2" <<<"$3"; then
    printf 'PASS %s\n' "$1"
    pass=$((pass + 1))
    return
  fi

  printf 'FAIL %s\n  wanted: %s\n' "$1" "$2"
  printf '%s\n' "$3" | tail -15 | sed 's/^/  | /'
  fail=$((fail + 1))
}

# expect_not <name> <substring> <output>: PASS when output lacks substring.
expect_not() {
  if grep -qF -- "$2" <<<"$3"; then
    printf 'FAIL %s\n  unwanted: %s\n' "$1" "$2"
    fail=$((fail + 1))
    return
  fi

  printf 'PASS %s\n' "$1"
  pass=$((pass + 1))
}

clean() {
  find "$script_dir" -name .terragrunt-cache -type d -prune -exec rm -rf {} +
  find "$script_dir" -name 'terraform.tfstate*' -delete
  find "$script_dir" -name .terraform.lock.hcl -delete
}

clean

printf '\n== 01-basic\n'
out="$(tg 01-basic/app render)"
expect "01 render resolves inputs from the vpc mocks" 'vpc_id     = "vpc-mock"' "$out"
out="$(cd "$script_dir/01-basic/app" && "$terragrunt_bin" render --format json 2>/dev/null)"
expect "01 render json inputs hold the mocks" '"inputs":{"subnet_ids":["subnet-mock-1","subnet-mock-2"],"vpc_id":"vpc-mock"}' "$out"
expect "01 dependent declares no mock_outputs itself" '"mock_outputs":null' "$out"
out="$(cd "$script_dir/01-basic/vpc" && "$terragrunt_bin" render --format json 2>/dev/null)"
expect "01 vpc render json shows the contract" '"output":{"subnet_ids":{"mock_value":["subnet-mock-1","subnet-mock-2"]},"vpc_id":{"mock_value":"vpc-mock"}}' "$out"
out="$(tg 01-basic/app plan)"
expect "01 plan before apply uses the vpc mocks" '+ vpc_id     = "vpc-mock"' "$out"
expect "01 list mock too" '"subnet-mock-1"' "$out"
out="$(tg 01-basic run --all -- apply -auto-approve)"
expect "01 run --all apply succeeds" 'Succeeded    2' "$out"
out="$(tg 01-basic/app output -json)"
expect "01 app output holds the real vpc_id" '"vpc-real"' "$out"
expect "01 app output holds the real subnet_ids" '"subnet-real-1"' "$out"

printf '\n== 02-override-key\n'
out="$(tg 02-override-key/app plan)"
expect "02 dependent key wins" '+ vpc_id     = "vpc-override"' "$out"
expect "02 other key comes from the block" '"subnet-mock-1"' "$out"

printf '\n== 03-allowed-commands\n'
out="$(tg 03-allowed-commands/app plan)"
expect "03 plan runs on mocks" '+ vpc_id     = "vpc-mock"' "$out"
out="$(tg 03-allowed-commands/app apply -auto-approve)"
expect "03 apply refuses mocks" 'but detected no outputs' "$out"
out="$(tg 03-allowed-commands/app-strict plan)"
expect "03 dependent tightens the allowed commands" 'but detected no outputs' "$out"

printf '\n== 04-merge-with-state\n'
out="$(tg 04-merge-with-state/vpc apply -auto-approve)"
expect "04 vpc applies" 'Apply complete!' "$out"
out="$(tg 04-merge-with-state/app plan)"
expect "04 nat_id filled from mock" '+ nat_id = "nat-mock"' "$out"
expect "04 vpc_id from state" '+ vpc_id = "vpc-real"' "$out"

printf '\n== 05-include-shared\n'
out="$(tg 05-include-shared/vpc render)"
expect "05 deep merge keeps the root strategy" 'allowed_commands = ["validate", "plan"]' "$out"
expect "05 deep merge keeps the unit outputs" 'output "subnet_ids"' "$out"
out="$(tg 05-include-shared/db render)"
expect "05 shallow merge keeps the unit block" 'output "db_url"' "$out"
expect_not "05 shallow merge drops the root strategy" 'allowed_commands' "$out"

printf '\n== 06-read-contract\n'
out="$(tg 06-read-contract/app render --format json)"
expect "06 declared names via read_terragrunt_config" '"declared":["subnet_ids","vpc_id"]' "$out"
expect "06 mock values via read_terragrunt_config" '"vpc_id":"vpc-mock"' "$out"

printf '\n== 07-hcl-validate\n'
out="$(tg 07-hcl-validate hcl validate --outputs; printf 'exit=%s' "$?")"
expect "07 valid tree exits 0" 'exit=0' "$out"
expect_not "07 valid tree has no diagnostics" 'error:' "$out"

printf '\n== 08-hcl-validate-errors\n'
out="$(tg 08-hcl-validate-errors hcl validate --outputs; printf 'exit=%s' "$?")"
expect "08 undeclared reference reported" 'Undeclared dependency output' "$out"
expect "08 stale declaration reported" 'Declared output not in module' "$out"
expect "08 invalid tree exits 1" 'exit=1' "$out"

printf '\n== 09-tip-missing-block\n'
out="$(tg 09-tip-missing-block/app plan)"
expect "09 tip is logged" 'TIP (outputs-block)' "$out"
out="$(tg 09-tip-missing-block/app --no-tip outputs-block plan)"
expect_not "09 --no-tip silences it" 'TIP (outputs-block)' "$out"

printf '\n== 10-error-experiment-off\n'
out="$(cd "$script_dir/10-error-experiment-off/vpc" && env -u TG_EXPERIMENT "$terragrunt_bin" plan 2>&1)"
expect "10 block needs the experiment" 'needs the outputs-block experiment' "$out"

printf '\n== 11-error-duplicate-output\n'
out="$(tg 11-error-duplicate-output/vpc plan)"
expect "11 duplicate output rejected" 'declares output "vpc_id" more than once' "$out"

printf '\n== 12-error-invalid-block\n'
out="$(tg 12-error-invalid-block/deep-merge plan)"
expect "12 deep strategy rejected" 'Valid values are: no_merge, shallow, deep_map_only' "$out"
out="$(tg 12-error-invalid-block/type-attribute plan)"
expect "12 type attribute rejected" 'An argument named "type" is not expected here' "$out"
out="$(tg 12-error-invalid-block/two-blocks plan)"
expect "12 second outputs block rejected" 'Duplicate outputs block' "$out"

printf '\n== 13-error-stale-declaration\n'
out="$(tg 13-error-stale-declaration/app plan)"
expect "13 plan on mocks before apply is fine" '+ nat_id = "nat-mock"' "$out"
out="$(tg 13-error-stale-declaration/vpc apply -auto-approve)"
expect "13 vpc applies" 'Apply complete!' "$out"
out="$(tg 13-error-stale-declaration/app plan)"
expect "13 missing declared output is an error" 'but its state has no output "nat_id"' "$out"

clean

printf '\n%d passed, %d failed\n' "$pass" "$fail"
[ "$fail" -eq 0 ]
