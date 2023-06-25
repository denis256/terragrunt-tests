
resource "null_resource" "script" {

   triggers = {
    run = "${timestamp()}"
   }

  provisioner "local-exec" {
    command = "/bin/bash script.sh"
  }
}

output "x" {
  value = "1"
}