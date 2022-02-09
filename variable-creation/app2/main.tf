resource "local_file" "file" {
    content     = "str: ${var.obj.str}"
    filename = "${path.module}/file.txt"
}