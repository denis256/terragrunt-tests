resource "local_file" "mod2" {
    content     = "mod2 ${var.mod2_content}"
    filename = "${path.module}/mod2.txt"
}
