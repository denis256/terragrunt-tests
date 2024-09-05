generate "main" {
  path      = "main.tf"
  if_exists = "overwrite"
  contents  = <<EOF
variable "stuff" {
  type = map(string)
}

variable "foo" {
  type = string
}

output "stuff" {
  value = var.stuff
}

output "foo" {
  value = var.foo
}
EOF
}

inputs = {
  stuff = replace(file("${get_terragrunt_dir()}/foo.json"), "${", "$$")

  foo = jsondecode(file("${get_terragrunt_dir()}/foo.json")).foo
}