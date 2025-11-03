#!/usr/bin/env bash
# Terragrunt Performance Comparison Script
# Compares performance between two Terragrunt binaries

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DEV_BINARY="${DEV_BINARY:-/projects/gruntwork/terragrunt-2/terragrunt}"
RELEASE_BINARY="${RELEASE_BINARY:-/home/denis256/bin/terragrunt}"
RUNS="${RUNS:-5}"  # Number of runs per benchmark
FIXTURE_DIR="${FIXTURE_DIR:-/projects/gruntwork/terragrunt-2/test/fixtures}"

echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Terragrunt Performance Comparison${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo ""

# Verify binaries exist
if [ ! -f "$DEV_BINARY" ]; then
    echo -e "${RED}Error: Dev binary not found at $DEV_BINARY${NC}"
    exit 1
fi

if [ ! -f "$RELEASE_BINARY" ]; then
    echo -e "${RED}Error: Release binary not found at $RELEASE_BINARY${NC}"
    exit 1
fi

# Get versions
echo -e "${YELLOW}Dev Binary:${NC}     $DEV_BINARY"
DEV_VERSION=$("$DEV_BINARY" --version 2>&1 | grep -i "terragrunt version" | head -1)
echo -e "                Version: $DEV_VERSION"
echo ""

echo -e "${YELLOW}Release Binary:${NC} $RELEASE_BINARY"
RELEASE_VERSION=$("$RELEASE_BINARY" --version 2>&1 | grep -i "terragrunt version" | head -1)
echo -e "                Version: $RELEASE_VERSION"
echo ""

echo -e "${YELLOW}Benchmark Runs:${NC} $RUNS per test"
echo ""

# Function to run a benchmark
run_benchmark() {
    local name="$1"
    local fixture="$2"
    local command="$3"
    local binary="$4"

    local total_time=0
    local times=()

    for i in $(seq 1 "$RUNS"); do
        # Clean up before each run
        find "$fixture" -name ".terragrunt-cache" -type d -exec rm -rf {} + 2>/dev/null || true
        find "$fixture" -name "terraform.tfstate*" -delete 2>/dev/null || true
        find "$fixture" -name ".terraform" -type d -exec rm -rf {} + 2>/dev/null || true
        find "$fixture" -name ".terraform.lock.hcl" -delete 2>/dev/null || true

        # Run and measure time
        local start=$(date +%s%N)
        (cd "$fixture" && eval "$binary $command" > /dev/null 2>&1) || true
        local end=$(date +%s%N)

        local duration=$((($end - $start) / 1000000))  # Convert to milliseconds
        times+=($duration)
        total_time=$(($total_time + $duration))
    done

    # Calculate average
    local avg=$(($total_time / $RUNS))

    # Calculate min and max
    local min=${times[0]}
    local max=${times[0]}
    for time in "${times[@]}"; do
        [ $time -lt $min ] && min=$time
        [ $time -gt $max ] && max=$time
    done

    echo "$avg|$min|$max"
}

# Function to print benchmark results
print_results() {
    local name="$1"
    local dev_result="$2"
    local release_result="$3"

    IFS='|' read -r dev_avg dev_min dev_max <<< "$dev_result"
    IFS='|' read -r release_avg release_min release_max <<< "$release_result"

    echo -e "${GREEN}$name${NC}"
    echo "  Dev (this branch):"
    printf "    Avg: %6d ms  |  Min: %6d ms  |  Max: %6d ms\n" "$dev_avg" "$dev_min" "$dev_max"
    echo "  Release (v0.93.0):"
    printf "    Avg: %6d ms  |  Min: %6d ms  |  Max: %6d ms\n" "$release_avg" "$release_min" "$release_max"

    # Calculate percentage difference
    local diff=$((dev_avg - release_avg))
    local pct_diff=$(awk "BEGIN {printf \"%.2f\", ($diff / $release_avg) * 100}")

    if (( $(echo "$pct_diff > 0" | bc -l) )); then
        echo -e "  ${RED}Slower by $pct_diff% (+${diff}ms)${NC}"
    elif (( $(echo "$pct_diff < 0" | bc -l) )); then
        echo -e "  ${GREEN}Faster by ${pct_diff#-}% (${diff}ms)${NC}"
    else
        echo -e "  ${YELLOW}Same performance${NC}"
    fi
    echo ""
}

echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Running Benchmarks (${RUNS} runs each)${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo ""

# Benchmark 1: Simple discovery (find command)
if [ -d "$FIXTURE_DIR/dependency-output" ]; then
    echo -e "${YELLOW}[1/5]${NC} Running: find command (simple discovery)..."
    DEV_RESULT=$(run_benchmark "Find Command" "$FIXTURE_DIR/dependency-output" "find" "$DEV_BINARY")
    RELEASE_RESULT=$(run_benchmark "Find Command" "$FIXTURE_DIR/dependency-output" "find" "$RELEASE_BINARY")
    print_results "1. Find Command (Simple Discovery)" "$DEV_RESULT" "$RELEASE_RESULT"
fi

# Benchmark 2: Run all with dependencies
if [ -d "$FIXTURE_DIR/dependency-output" ]; then
    echo -e "${YELLOW}[2/5]${NC} Running: run --all plan (with dependencies)..."
    DEV_RESULT=$(run_benchmark "Run All Plan" "$FIXTURE_DIR/dependency-output" "run --all --non-interactive -- plan" "$DEV_BINARY")
    RELEASE_RESULT=$(run_benchmark "Run All Plan" "$FIXTURE_DIR/dependency-output" "run --all --non-interactive -- plan" "$RELEASE_BINARY")
    print_results "2. Run --all Plan (With Dependencies)" "$DEV_RESULT" "$RELEASE_RESULT"
fi

# Benchmark 3: HCL parsing
if [ -d "$FIXTURE_DIR/dependency-output" ]; then
    echo -e "${YELLOW}[3/5]${NC} Running: hcl show (HCL parsing)..."
    DEV_RESULT=$(run_benchmark "HCL Show" "$FIXTURE_DIR/dependency-output/app" "hcl show" "$DEV_BINARY")
    RELEASE_RESULT=$(run_benchmark "HCL Show" "$FIXTURE_DIR/dependency-output/app" "hcl show" "$RELEASE_BINARY")
    print_results "3. HCL Show (Parsing Performance)" "$DEV_RESULT" "$RELEASE_RESULT"
fi

# Benchmark 4: Graph generation
if [ -d "$FIXTURE_DIR/dependency-output" ]; then
    echo -e "${YELLOW}[4/5]${NC} Running: dag (graph generation)..."
    DEV_RESULT=$(run_benchmark "DAG Generation" "$FIXTURE_DIR/dependency-output" "dag --working-dir ." "$DEV_BINARY")
    RELEASE_RESULT=$(run_benchmark "DAG Generation" "$FIXTURE_DIR/dependency-output" "dag --working-dir ." "$RELEASE_BINARY")
    print_results "4. DAG (Graph Generation)" "$DEV_RESULT" "$RELEASE_RESULT"
fi

# Benchmark 5: Auth provider parallel (if available)
if [ -d "$FIXTURE_DIR/auth-provider-parallel" ]; then
    echo -e "${YELLOW}[5/5]${NC} Running: run --all validate (auth provider parallel)..."
    DEV_RESULT=$(run_benchmark "Auth Provider" "$FIXTURE_DIR/auth-provider-parallel" "run --all --non-interactive -- validate" "$DEV_BINARY")
    RELEASE_RESULT=$(run_benchmark "Auth Provider" "$FIXTURE_DIR/auth-provider-parallel" "run --all --non-interactive -- validate" "$RELEASE_BINARY")
    print_results "5. Auth Provider Parallel (Runner Pool)" "$DEV_RESULT" "$RELEASE_RESULT"
fi

echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Benchmark Complete${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}Note:${NC} Results show average time over $RUNS runs"
echo -e "      Negative % = faster, Positive % = slower"
echo ""
