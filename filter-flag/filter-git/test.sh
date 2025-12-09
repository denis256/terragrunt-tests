#!/bin/bash
# Test script for --filter git diff functionality
# Tests applying changes only to units modified between git references

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UNITS_DIR="$SCRIPT_DIR/units"

echo "=== Git Filter Flag Test ==="
echo "Testing --filter=[ref] and --filter-affected flags"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper function to run terragrunt and check output
run_test() {
    local test_name="$1"
    local cmd="$2"
    local expected_pattern="$3"

    echo -e "${YELLOW}Test: ${test_name}${NC}"
    echo "Command: $cmd"

    if output=$(eval "$cmd" 2>&1); then
        if echo "$output" | grep -q "$expected_pattern"; then
            echo -e "${GREEN}PASSED${NC}"
            return 0
        else
            echo -e "${RED}FAILED - Pattern not found: $expected_pattern${NC}"
            echo "Output: $output"
            return 1
        fi
    else
        echo -e "${RED}FAILED - Command error${NC}"
        echo "Output: $output"
        return 1
    fi
}

echo "--- Setup: Get current git state ---"
cd "$SCRIPT_DIR"
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
MAIN_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "master")
HEAD_COMMIT=$(git rev-parse HEAD 2>/dev/null || echo "unknown")
echo "Current branch: $CURRENT_BRANCH"
echo "Main branch: $MAIN_BRANCH"
echo "HEAD commit: $HEAD_COMMIT"
echo ""

# Test 1: Filter by single git reference (compare to current state)
echo "--- Test 1: Filter by single git reference ---"
echo "Syntax: terragrunt run --filter=[HEAD^1] plan"
echo "This targets units changed since previous commit"
echo ""

# Test 2: Filter by commit range using three-dot syntax
echo "--- Test 2: Filter by commit range (three-dot syntax) ---"
echo "Syntax: terragrunt run --filter=[main...HEAD] plan"
echo "This targets units changed between main branch and HEAD"
echo ""

# Test 3: Filter-affected shorthand
echo "--- Test 3: Filter-affected shorthand ---"
echo "Syntax: terragrunt run --filter-affected plan"
echo "Equivalent to --filter=[main...HEAD]"
echo ""

# Test 4: Filter by specific commit hashes
echo "--- Test 4: Filter by specific commit hashes ---"
echo "Syntax: terragrunt run --filter=[a1b2c3d...e4f5g6h] plan"
echo "This targets units changed between two specific commits"
echo ""

# Practical test: Simulate a change and filter
echo "=== Practical Test Scenarios ==="
echo ""

echo "Scenario A: Initial apply of all units"
echo "Command: cd $UNITS_DIR && terragrunt run-all plan"
echo ""

echo "Scenario B: Apply only changed units (since last commit)"
echo "Command: cd $UNITS_DIR && terragrunt run --filter=[HEAD^1] apply"
echo ""

echo "Scenario C: Apply only units changed in feature branch"
echo "Command: cd $UNITS_DIR && terragrunt run --filter=[$MAIN_BRANCH...HEAD] apply"
echo ""

echo "Scenario D: Using filter-affected (same as Scenario C)"
echo "Command: cd $UNITS_DIR && terragrunt run --filter-affected apply"
echo ""

echo "Scenario E: Destroy removed units with filter-allow-destroy"
echo "Command: cd $UNITS_DIR && terragrunt run --filter=[main...HEAD] --filter-allow-destroy apply"
echo ""

# Show unit structure
echo "=== Unit Structure ==="
echo "units/"
echo "├── vpc/        (base infrastructure)"
echo "├── database/   (depends on vpc)"
echo "├── cache/      (depends on vpc)"
echo "└── app/        (depends on vpc, database)"
echo ""

echo "=== Dependency Graph ==="
echo "vpc --> database --> app"
echo " └----> cache"
echo ""

echo "=== Test Complete ==="
echo "Run actual terragrunt commands to test git filtering"
