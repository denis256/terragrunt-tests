variable path {}


output path {
	value = var.path
}



resource "local_file" "path" {
  content  = var.path
  filename = "${path.module}/path.txt"
}


resource "null_resource" "print" {
  triggers = {
    always = timestamp()
  }

  provisioner "local-exec" {
    command = "echo ${var.path}"
  }
}