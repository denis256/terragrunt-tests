generate = {
  test = {
    path      = "test.tf"
    if_exists = "overwrite"
    contents  = <<EOF
variable "text" { }
variable "text22" { }
EOF
  }
}

locals {

  cache_path = run_cmd("bash", "-c", "ls -td .terragrunt-cache/*/* | head -1")
  path2 = run_cmd("echo", find_in_parent_folders("test.tf"))
}
terraform {
  source = "./module2"
}
