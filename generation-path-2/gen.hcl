generate = {
  test = {
    path      = "test.tf"
    if_exists = "overwrite"
    contents  = <<EOF
variable "text" { }
EOF
  }
}
