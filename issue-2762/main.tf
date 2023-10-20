resource "null_resource" "script" {

  provisioner "local-exec" {

    command = "/bin/bash 46521694.sh"
  }
}