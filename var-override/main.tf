variable "some_number" {
  default     = 3
  type        = number
}

resource "null_resource" "date" {

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "env && echo ${var.some_number}"
    interpreter = ["bash", "-c"]
  }
}
