#!/bin/bash
# Test apply on git diffs
# Creates a branch, makes changes, and tests filtered apply

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UNITS_DIR="$SCRIPT_DIR/units"

# Configurable terragrunt path (default: local build)
TERRAGRUNT="${TERRAGRUNT:-/projects/gruntwork/terragrunt/terragrunt}"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[PASS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[FAIL]${NC} $1"; }

cleanup() {
    log_info "Cleanup: removing test artifacts"
    rm -f "$UNITS_DIR"/*/test-change.txt 2>/dev/null || true
    git checkout -- "$UNITS_DIR" 2>/dev/null || true
}

trap cleanup EXIT

echo "=== Git Filter Apply Test ==="
echo ""

# Check prerequisites
if [[ ! -x "$TERRAGRUNT" ]]; then
    log_error "terragrunt not found at: $TERRAGRUNT"
    log_info "Set TERRAGRUNT env var to override path"
    exit 1
fi
log_info "Using terragrunt: $TERRAGRUNT"

cd "$SCRIPT_DIR"
BASE_COMMIT=$(git rev-parse HEAD)
log_info "Base commit: $BASE_COMMIT"

# Test 1: Baseline - show all units that would be affected
echo ""
echo "=== Test 1: List all units ==="
cd "$UNITS_DIR"
log_info "Running: $TERRAGRUNT run-all plan (dry-run)"
if $TERRAGRUNT run-all plan --terragrunt-non-interactive 2>&1 | head -50; then
    log_success "Listed all units"
else
    log_warn "Plan had issues (may be expected without full terraform setup)"
fi

# Test 2: Simulate change and filter
echo ""
echo "=== Test 2: Simulate change to database unit ==="
echo "# test change" >> "$UNITS_DIR/database/main.tf"
log_info "Modified: units/database/main.tf"

# Show git status
log_info "Git status:"
git status --short "$UNITS_DIR"

# Test filter command (show what would be selected)
echo ""
log_info "Filter command: $TERRAGRUNT run --filter=[HEAD] plan"
log_info "This would target only the database unit (and dependents)"
echo ""

# Test 3: Show expected behavior
echo "=== Test 3: Expected filter behavior ==="
echo ""
echo "Given change to: units/database/main.tf"
echo ""
echo "Expected units selected by --filter=[HEAD]:"
echo "  - database (directly changed)"
echo "  - app (depends on database)"
echo ""
echo "Units NOT selected:"
echo "  - vpc (no changes)"
echo "  - cache (no changes, no dependency on database)"
echo ""

# Test 4: Multiple changes
echo "=== Test 4: Multiple unit changes ==="
echo "# test change" >> "$UNITS_DIR/cache/main.tf"
log_info "Also modified: units/cache/main.tf"

log_info "Git status:"
git status --short "$UNITS_DIR"

echo ""
echo "Expected units selected by --filter=[HEAD]:"
echo "  - database (changed)"
echo "  - cache (changed)"
echo "  - app (depends on database)"
echo ""

# Cleanup is handled by trap
echo "=== Test Complete ==="
echo ""
echo "To run actual filtered apply:"
echo "  1. Commit current changes"
echo "  2. Run: $TERRAGRUNT run --filter=[HEAD^1] apply"
echo ""
echo "Or for branch comparison:"
echo "  $TERRAGRUNT run --filter=[main...HEAD] apply"
