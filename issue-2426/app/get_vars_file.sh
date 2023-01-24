#!/usr/bin/env bash
#echo "vars.$(terragrunt workspace show).tfvars"
echo "$(cat $(find . -name "environment"))" > /tmp/tmp_vars.tfvars