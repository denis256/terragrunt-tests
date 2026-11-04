# Bug: discovery picks terragrunt.hcl, loader prefers terragrunt.hcl.json

Related PR: gruntwork-io/terragrunt#6910
Code refs: internal/discovery/helpers.go:42-46 + 220-235 (discovery side),
pkg/config/config.go:101-105 + 1393-1402 (loader side),
internal/discovery/phase_parse.go:347-349 and internal/runner/runner.go:104-106 (consumers).

## Repro layout

issue-discovery-json-precedence/
├── my-unit/
│   ├── main.tf               variable "env" + output "env" (so plan shows the value)
│   ├── terragrunt.hcl        inputs = { env = "hcl" }
│   └── terragrunt.hcl.json   {"inputs": {"env": "json"}}
├── README.md                 this file
├── output-main.txt           recorded outputs, binary built from origin/main 3e574b36c
└── output-branch.txt         recorded outputs, binary built from PR branch 88f516a1b

## How to reproduce manually (no script)

cp -r my-unit /tmp/run && cd /tmp/run

# Command 1 - discovery-based path, from the PARENT dir:
terragrunt run --all plan

# Command 2 - single-directory path, inside the unit:
cd /tmp/run/my-unit && terragrunt plan

## Recorded results (both binaries, opentofu backend, 2026-09-16)

Binary built from origin/main (commit 3e574b36c), full log in output-main.txt:

  Command 1 (run --all plan):   [my-unit] tofu:   + env = "hcl"
  Command 2 (plan):                       tofu:   + env = "json"

Binary built from PR branch fix/discovery-hcl-json-config-filenames
(commit 88f516a1b), full log in output-branch.txt:

  Command 1 (run --all plan):   [my-unit] tofu:   + env = "hcl"
  Command 2 (plan):                       tofu:   + env = "json"

## What is expected

Both commands must agree. GetDefaultConfigPath checks
DefaultTerragruntConfigPaths in order [terragrunt.hcl.json, terragrunt.hcl],
so terragrunt.hcl.json wins and both commands should print env = "json".

## Why it fails

- Discovery walks lexically: "terragrunt.hcl" is visited before
  "terragrunt.hcl.json". Each match creates a Unit with the same path
  (the dir). deduplicateResults keeps the FIRST result, so
  unit.ConfigFile() = "terragrunt.hcl".
- Parse and run phases load exactly that file
  (phase_parse.go uses unit.ConfigFile(); runner.go uses unit.ConfigFile()).
- Command 1 therefore uses terragrunt.hcl -> env = "hcl".
- Command 2 does not use discovery; GetDefaultConfigPath prefers JSON
  -> env = "json".
- Same directory, two different plans, no warning. Behavior is identical
  on main and on the PR branch: PR #6910 makes the JSON file discoverable
  but does not change which file wins when both exist.

## User impact

- terragrunt run --all apply / plan / any --filter command applies terragrunt.hcl
- terragrunt apply / plan inside the unit applies terragrunt.hcl.json
- Different backend, inputs, or iam_role config can be applied to real
  infrastructure depending only on how terragrunt was invoked.
- Nothing in the output names the chosen config file or warns that both exist.

## Fix direction

Make discovery prefer terragrunt.hcl.json for a directory containing both
files (match loader precedence), or emit a warning/error when both config
files exist in one unit directory. Lock the behavior with a test.
