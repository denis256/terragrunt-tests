resource "local_file" "mod1" {
    content     = "mod1 ${var.mod1_content}"
    filename = "${path.module}/mod1.txt"
}
