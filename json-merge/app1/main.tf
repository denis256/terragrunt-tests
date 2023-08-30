resource "local_file" "mod1" {
  content     = "mod1"
  filename = "${path.module}/mod1.txt"
}

