#!/usr/bin/env bash
# Quick Terragrunt Performance Comparison
# Simple script using 'time' command for quick comparisons

set -e

# Configuration
DEV_BINARY="${DEV_BINARY:-/projects/gruntwork/terragrunt-2/terragrunt}"
RELEASE_BINARY="${RELEASE_BINARY:-/home/denis256/bin/terragrunt}"
FIXTURE="${FIXTURE:-/projects/gruntwork/terragrunt-tests/dependency-output}"
COMMAND="${COMMAND:-run --all --non-interactive -- apply}"

echo "=========================================="
echo "  Quick Terragrunt Benchmark"
echo "=========================================="
echo ""
echo "Dev Binary:     $DEV_BINARY"
echo "Release Binary: $RELEASE_BINARY"
echo "Test Fixture:   $FIXTURE"
echo "Command:        $COMMAND"
echo ""
echo "=========================================="
echo ""

# Function to clean and run
run_test() {
    local binary="$1"
    local label="$2"

    echo "[$label] Cleaning..."
    find "$FIXTURE" -name ".terragrunt-cache" -type d -exec rm -rf {} + 2>/dev/null || true
    find "$FIXTURE" -name "terraform.tfstate*" -delete 2>/dev/null || true
    find "$FIXTURE" -name ".terraform" -type d -exec rm -rf {} + 2>/dev/null || true
    find "$FIXTURE" -name ".terraform.lock.hcl" -delete 2>/dev/null || true

    echo "[$label] Running: $binary $COMMAND"
    echo ""

    (cd "$FIXTURE" && time "$binary" $COMMAND 2>&1 | tail -10)

    echo ""
    echo "=========================================="
    echo ""
}

# Run dev version
run_test "$DEV_BINARY" "DEV (this branch)"

# Run release version
run_test "$RELEASE_BINARY" "RELEASE (v0.93.0)"

echo "Benchmark Complete!"
echo ""
echo "Usage: You can customize with environment variables:"
echo "  FIXTURE=/path/to/fixture ./benchmark-quick.sh"
echo "  COMMAND='find' ./benchmark-quick.sh"
echo "  RUNS=10 ./benchmark-compare.sh  # for detailed comparison"
