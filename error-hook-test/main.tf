

resource "null_resource" "date" {

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "echo 'azurerm_resource_group' && exit 1"
    interpreter = ["bash", "-c"]
  }
}
