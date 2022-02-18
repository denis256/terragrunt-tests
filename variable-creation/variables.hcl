generate = {
  gen = {
    path      = "variables.tf"
    if_exists = "overwrite"
    contents  = <<EOF
# variables.tf
variable "obj" {
  type = object({
    str = string
  })
}
EOF
  }
}
