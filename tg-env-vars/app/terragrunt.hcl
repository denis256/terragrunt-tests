
generate "modules" {
  path      = "modules.tf"
  if_exists = "overwrite"
  contents = <<EOF
module "m1" {
    source = "${get_repo_root()}/tg-env-vars/module"
}
EOF
}