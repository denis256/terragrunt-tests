#!/bin/bash

cd $(dirname "$0")
cd ..
cd run_cmd_error
terragrunt apply -auto-approve --terragrunt-non-interactive