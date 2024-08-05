#!/usr/bin/env bash

export EXECUTABLE="${EXECUTABLE:-terragrunt}"

cd test/code

echo "executable: ${EXECUTABLE}"
${EXECUTABLE} run-all apply --terragrunt-non-interactive
