#!/bin/bash

init() {
    echo "$(pwd): init"
    cat >terragrunt.hcl <<'EOM'
include "root" {
  path = find_in_parent_folders("terragrunt-test.hcl")
}
EOM
    cat >main.tf <<'EOM'
EOM
}

cat >terragrunt-test.hcl <<'EOM'
terraform {
  # so our terragrunt logging shows more progress
  before_hook "starting" {
    commands = ["init", "plan", "apply"]
    execute  = ["true"]
  }

  before_hook "setup-module-cache" {
    commands = ["init"]
    execute = ["sleep", "2"]
  }

  before_hook "pre-apply-plan" {
    commands = ["apply"]
    execute = ["sleep", "5"]
  }

  after_hook "plan-convert" {
    commands = ["plan"]
    execute = ["sleep", "1"]
  }

  after_hook "complete" {
    commands     = ["init", "plan", "apply"]
    execute      = ["true"]
    run_on_error = true
  }
}
EOM

for i in $(seq 10); do
    mkdir -p acct$i
    pushd acct$i >/dev/null
    init
    for j in $(seq 4); do
        mkdir -p region$j
        pushd region$j >/dev/null
        init
        popd >/dev/null
    done
    popd >/dev/null
done