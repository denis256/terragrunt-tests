
generate "test" {
  path = "example_backend.txt"
  if_exists = "overwrite"
  contents = <<EOF
example_backend
EOF
}
