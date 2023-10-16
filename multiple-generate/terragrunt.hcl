generate "provider" {
  path      = "file.txt"
  if_exists = "overwrite"
  contents = <<EOF
p1
EOF
}

generate "provider2" {
  path      = "file.txt"
  if_exists = "overwrite"
  contents = <<EOF
p2
EOF
}