generate "provider2" {
  path      = "provider2.tf"
  if_exists = "overwrite"
  contents = <<EOF
# test
EOF
}

generate "provider3" {
  path      = "provider3.tf"
  if_exists = "overwrite"
  contents = <<EOF
# test
EOF
}