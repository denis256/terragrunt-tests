generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF

resource "local_file" "file" {
    content     = "auto generated file example"
    filename = "file.txt"
}

EOF
}