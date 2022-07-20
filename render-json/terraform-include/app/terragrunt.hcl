include "project" {
  path   = "../commons/project.hcl"
  merge_strategy = "deep"
}


generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
# test
EOF
}