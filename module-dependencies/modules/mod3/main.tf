resource "local_file" "mod3" {
    content     = "mod3 ${var.mod3_content}"
    filename = "${path.module}/mod3.txt"
}
