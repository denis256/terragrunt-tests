#!/usr/bin/env bash

export EXECUTABLE="${EXECUTABLE:-terragrunt}"

cd test/code

terragrunt run-all apply --terragrunt-non-interactive
