locals {
  names = ["bob", "stewart"]
}

generate "file" {
  for_each = toset(locals.names)
  path = "file.txt"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF

file
EOF
}