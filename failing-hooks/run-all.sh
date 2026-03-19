#!/bin/bash
# Run all failing-hook scenarios to test error message output.
# Usage: ./run-all.sh [path-to-terragrunt-binary]
#
# Each scenario should show the command, exit code, and hook output in the error.

TG="${1:-terragrunt}"
DIR="$(cd "$(dirname "$0")" && pwd)"

for scenario in stderr-hook stdout-hook multiline-hook missing-binary; do
  echo "============================================"
  echo "SCENARIO: $scenario"
  echo "============================================"
  (cd "$DIR/$scenario" && $TG run plan --non-interactive 2>&1) || true
  echo ""
done
