locals {
  terraform_state_s3_bucket        = "denis-test-2023-11-terraform"
  terraform_state_s3_bucket_region = local.global_vars["region"]
  terraform_config_profile         = local.global_vars["aws_profile"]
  terraform_state_dynamodb_table   = "org1-terraform-lock"
  terraform_state_s3_key           = "terragrunt/${path_relative_to_include()}/terraform.tfstate"
  global_vars                      = yamldecode(file(find_in_parent_folders("global_settings.yaml")))
  terraform_cache_dir              = format("%s/%s", get_env("TF_PLUGIN_CACHE_DIR",  abspath("${get_repo_root()}/.terragrunt-cache/.plugins")), path_relative_to_include())
}

remote_state {
  backend = "s3"
  // disable_dependency_optimization = false
  config = {
    dynamodb_table = local.terraform_state_dynamodb_table
    bucket         = local.terraform_state_s3_bucket
    region         = local.terraform_state_s3_bucket_region
    profile        = local.terraform_config_profile
    key            = local.terraform_state_s3_key
    encrypt        = true


    s3_bucket_tags = {
      Name = "Terraform state storage"
    }

    dynamodb_table_tags = {
      Name = "Terraform lock table"
    }
  }
}

terraform {
  extra_arguments "disable_input" {
    commands  = get_terraform_commands_that_need_input()
    arguments = ["-input=false"]
  }


#  before_hook "copy_global_providers" {
#    commands     = ["init-from-module","plan"]
#    execute      = ["wget", "-qN", "https://raw.githubusercontent.com/org1/terraform-modules-public/v0.0.6/_global/_global_providers.tf"]
#    run_on_error = true
#  }


  before_hook "provider_cache" {
    commands = ["init", "validate", "plan", "apply"]
    execute  = ["mkdir", "-pv", local.terraform_cache_dir]
  }

  extra_arguments "regional_vars" {
    commands = get_terraform_commands_that_need_vars()

    optional_var_files = [
      "${get_parent_terragrunt_dir()}/_global/global.tfvars",
      "${get_terragrunt_dir()}/../regional.tfvars",
      "${get_terragrunt_dir()}/../../regional.tfvars",
      "${get_terragrunt_dir()}/../../../regional.tfvars",
      "${get_terragrunt_dir()}/../../../../regional.tfvars",
      "${get_terragrunt_dir()}/../terragrunt.tfvars",
      "${get_terragrunt_dir()}/../../terragrunt.tfvars",
      "${get_terragrunt_dir()}/../../../terragrunt.tfvars",
      "${get_terragrunt_dir()}/../../../../terragrunt.tfvars",
    ]
  }

  // adding caching of plugins instead of downloading again /tmp/tfplugins
  extra_arguments "set_env_vars" {
    commands = [get_terraform_command()]

    env_vars = {
      TF_PLUGIN_CACHE_DIR = local.terraform_cache_dir
      KUBE_CONFIG_PATH = get_env("KUBE_CONFIG_PATH", "~/.kube/config")
    }
  }

}

download_dir = abspath("${get_repo_root()}/.terragrunt-cache")

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = {
  aws_profile                      = local.terraform_config_profile
  aws_allowed_account_ids          = tolist([local.global_vars["aws_account_id"]])  # we should use list(get_aws_account_id()), but this does not work yet: https://github.com/gruntwork-io/terragrunt/issues/791
  terraform_state_s3_bucket        = local.terraform_state_s3_bucket
  terraform_state_s3_bucket_region = local.terraform_state_s3_bucket_region
  terraform_state_dynamodb_table   = local.terraform_state_dynamodb_table
}