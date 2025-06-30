
// do some custom logic here
generate "custom_logic" {
  path      = "custom_logic.tf"
  if_exists = "overwrite"
  contents  = <<EOF

resource "local_file" "app2" {
  content     = "app2"
  filename = "/tmp/app2.txt"
}

EOF
}

terraform {
  source = "../../terraform/modules/file-generator"
}

