#!/usr/bin/env bash
# Run every panic/hang reproduction case and classify the outcome.
#
# Usage:
#   ./run_all.sh                # uses the terragrunt on PATH
#   TG=/tmp/tg ./run_all.sh     # uses a specific binary
#
# Each case is run with a hang timeout. A case is reported as:
#   PANIC  the output contained a Go panic
#   HANG   the command was killed by the timeout (resource exhaustion)
#   OK     the command finished without a panic (bug not reproduced on this build)

set -uo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TG="${TG:-terragrunt}"
HANG_TIMEOUT="${HANG_TIMEOUT:-15}"

if ! command -v "$TG" >/dev/null 2>&1 && [[ ! -x "$TG" ]]; then
  echo "terragrunt binary not found (set TG=/path/to/terragrunt). Build with: go build -o /tmp/tg ." >&2
  exit 1
fi

run_case() {
  local dir="$1"; shift
  local label="$1"; shift
  local out rc
  out="$(cd "$here/$dir" && GOMEMLIMIT="${GOMEMLIMIT:-2GiB}" timeout "$HANG_TIMEOUT" "$TG" "$@" --working-dir . 2>&1)"
  rc=$?
  if grep -q "panic:" <<<"$out"; then
    printf '  PANIC  %-44s %s\n' "$label" "$(grep -m1 'partial_eval.go\|panic:' <<<"$out" | tr -s ' ')"
  elif [[ $rc -eq 124 ]]; then
    printf '  HANG   %-44s killed by timeout after %ss\n' "$label" "$HANG_TIMEOUT"
  elif [[ $rc -eq 137 || $rc -eq 134 ]]; then
    printf '  HANG   %-44s out of memory, process killed (exit %s)\n' "$label" "$rc"
  else
    printf '  OK     %-44s exit=%s (not reproduced on this build)\n' "$label" "$rc"
  fi
}

# Some cases are intermittent (a goroutine race). Retry until one run crashes.
run_case_retry() {
  local dir="$1"; shift
  local label="$1"; shift
  local tries="${RETRY:-5}" i out
  for ((i = 1; i <= tries; i++)); do
    out="$(cd "$here/$dir" && GOMEMLIMIT="${GOMEMLIMIT:-2GiB}" timeout "$HANG_TIMEOUT" "$TG" "$@" --working-dir . 2>&1)"
    if grep -q "panic:" <<<"$out"; then
      printf '  PANIC  %-44s on try %s/%s: %s\n' "$label" "$i" "$tries" "$(grep -m1 'dependency.go\|panic:' <<<"$out" | tr -s ' ')"
      return
    fi
  done
  printf '  OK     %-44s no panic in %s tries (race did not trip)\n' "$label" "$tries"
}

echo "Using terragrunt: $TG"
echo "Hang timeout: ${HANG_TIMEOUT}s"
echo

echo "01 numeric interpolation panic (gated):"
run_case "01-stack-numeric-interpolation-panic/live" "stack generate" stack generate --experiment stack-dependencies

echo "02 inputs bignum hang:"
run_case "02-inputs-bignum-hang" "render" render

echo "03 terraform.source bignum hang:"
run_case "03-terraform-source-bignum-hang" "render" render

echo "04 stack source bignum hang:"
run_case "04-stack-source-bignum-hang" "stack generate" stack generate

echo "05 dependency deep-merge non-string config_path panic (intermittent):"
run_case_retry "05-dependency-deepmerge-nonstring-panic/child" "hcl validate" hcl validate

echo "06 sensitive() marked value panic:"
run_case "06-sensitive-marked-value-panic/a-terraform-source" "a render" render
run_case "06-sensitive-marked-value-panic/b-stack-unit-source" "b stack generate" stack generate
run_case "06-sensitive-marked-value-panic/c-stack-values" "c stack generate" stack generate
run_case "06-sensitive-marked-value-panic/d-engine-meta" "d render" render

echo "07 deep nested inputs quadratic hang:"
run_case "07-deep-nested-quadratic-hang" "render --json" render --json

echo
echo "Done. Generated .terragrunt-stack and .terragrunt-cache dirs can be removed with:"
echo "  find . -name .terragrunt-stack -o -name .terragrunt-cache | xargs rm -rf"
