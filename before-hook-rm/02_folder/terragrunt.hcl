dependency "01" {
  config_path = "../01_folder"
  skip_outputs = true
}

terraform {
  before_hook "remove_apps" {
    commands = ["destroy"]
    execute  = ["sh", "-c", "for i in $(terragrunt state list | grep -E 'app1'); do terragrunt state rm $i; done"]
  }
}