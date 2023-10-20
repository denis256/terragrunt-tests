resource "null_resource" "health_check" {

  provisioner "local-exec" {

    command = "/bin/bash 46521694.sh"
  }
}