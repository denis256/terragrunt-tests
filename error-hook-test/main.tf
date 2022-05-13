

resource "null_resource" "date" {

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "cat /tmp/not-existing-file"
    interpreter = ["bash", "-c"]
  }
}
