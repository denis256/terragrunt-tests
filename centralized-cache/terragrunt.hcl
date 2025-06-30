terraform {
  before_hook "before_cache" {
    commands = [get_terraform_command()]
    execute  = ["mkdir", "-p", abspath("${get_repo_root()}/.terragrunt-cache/.plugins")]
  }
  extra_arguments "terragrunt_plugins" {
    commands = [get_terraform_command()]
    env_vars = {
      TF_PLUGIN_CACHE_DIR = abspath("${get_repo_root()}/.terragrunt-cache/.plugins")
      TERRAGRUNT_DOWNLOAD = abspath("${get_repo_root()}/.terragrunt-cache")
    }
  }
}
