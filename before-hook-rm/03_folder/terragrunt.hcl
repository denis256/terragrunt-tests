dependency "02" {
  config_path  = "../02_folder"
  skip_outputs = true
}

terraform {
  before_hook "remove_apps" {
    commands = ["destroy"]
    execute  = ["sh", "-c", "for i in $(terragrunt state list | grep -E 'app2'); do terragrunt state rm $i; done"]
  }
}