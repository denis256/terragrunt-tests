
resource "local_file" "vpc" {
  content     = "vpc for ${var.project_name}"
  filename = "${path.module}/vpc.txt"
}
