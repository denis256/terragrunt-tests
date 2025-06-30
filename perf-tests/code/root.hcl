# Based on https://www.bti360.com/creating-a-terraform-variable-hierarchy-with-terragrunt/

locals {
  root_deployments_dir       = get_parent_terragrunt_dir()
  relative_deployment_path   = path_relative_to_include()
  deployment_path_components = compact(split("/", local.relative_deployment_path))
  # Get a list of every path between root_deployments_directory and the path of
  # the deployment
  possible_config_dirs = [
    for i in range(0, length(local.deployment_path_components) + 1) :
    join("/", concat(
      [local.root_deployments_dir],
      slice(local.deployment_path_components, 0, i)
    ))
  ]
  # Generate a list of possible config files at every possible_config_dir
  # (support both .yml and .yaml)
  possible_config_paths = flatten([
    for dir in local.possible_config_dirs : [
      "${dir}/config.yml",
      "${dir}/config.yaml"
    ]
  ])
  # Load every YAML config file that exists into an HCL object
  file_configs = [
    for path in local.possible_config_paths :
    yamldecode(file(path)) if fileexists(path)
  ]
  # Merge the objects together, with deeper configs overriding higher configs
  merged_config = merge(local.file_configs...)
}
# Pass the merged config to terraform as variable values using TF_VAR_
# environment variables
inputs = local.merged_config

terraform {
  source = "${get_parent_terragrunt_dir()}//${path_relative_to_include()}"
}

remote_state {
  generate = {
    path      = "backend.tf"
    if_exists = "skip"
  }
  backend = "local"
  config  = {}
  #  backend = "http"
  #  config = {
  #    address = "http://myrest.api.com/foo/${path_relative_to_include()}"
  #    lock_address = "http://myrest.api.com/foo/${path_relative_to_include()}"
  #    unlock_address = "http://myrest.api.com/foo/${path_relative_to_include()}"
  #  }
}
