#!/usr/bin/env bash
# Full oci e2e: registry -> push -> terragrunt pull -> plan.
cd "$(dirname "$0")"
./01-start-registry.sh && ./02-push-module.sh && ./03-run-terragrunt.sh && ./04-cas-validation.sh && ./05-cas-evidence.sh
