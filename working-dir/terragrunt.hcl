terraform {
  source = "."
  extra_arguments "test" {
    commands = get_env("TERRAGRUNT_PROVIDER_CACHE", "0") == "1" ? [] : ["init"]
    arguments = [
      "-plugin-dir=.providers"
    ]
    env_vars = {
      TF_CLI_CONFIG_FILE = "${get_working_dir()}/terraform.tfrc"
    }
  }
}