variable "parameter_value" {
  sensitive = false

}

resource "aws_ssm_parameter" "myparamterstore" {
  name = "/myTestStore"
  description = "Test Description"
  type = "String"
  value = jsonencode((var.parameter_value))
  overwrite = true

}