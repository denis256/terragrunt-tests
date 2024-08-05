#!/usr/bin/env bash

export TERRAGRUNT_USE_PARTIAL_PARSE_CONFIG_CACHE=1
/projects/gruntwork/terragrunt/terragrunt "${@}"