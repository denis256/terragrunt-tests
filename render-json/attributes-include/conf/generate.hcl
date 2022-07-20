generate "provider1" {
  path      = "provider1.tf"
  if_exists = "overwrite"
  contents = <<EOF
# test
EOF
}

generate "provider666" {
  path      = "provider666.tf"
  if_exists = "overwrite"
  contents = <<EOF
# test
EOF
}