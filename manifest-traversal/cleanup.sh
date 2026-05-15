#!/usr/bin/env bash
# Cleans up artifacts left by reproduce.sh.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

rm -f /tmp/repro-manifest-traversal-sentinel-1.txt
rm -f /tmp/repro-manifest-traversal-sentinel-2.txt
rm -f /tmp/repro-manifest-traversal-sentinel-3.txt
rm -rf "$SCRIPT_DIR/consumer/.terragrunt-cache"
rm -rf "$SCRIPT_DIR/consumer/.terraform"
rm -f  "$SCRIPT_DIR/consumer/.terragrunt-init-required"
rm -rf "$SCRIPT_DIR/consumer-git"
rm -rf "$SCRIPT_DIR/attacker-repo-worktree"
rm -rf "$SCRIPT_DIR/attacker-repo.git"
rm -f  "$SCRIPT_DIR/attacker-module/.terragrunt-module-manifest"
rm -f  "$SCRIPT_DIR/forge_bin"
rm -rf "$SCRIPT_DIR/.scratch"
rm -f  /tmp/repro-manifest-traversal-rce-marker.txt
rm -rf /tmp/repro-victim

echo "cleaned."
