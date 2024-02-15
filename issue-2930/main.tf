resource "local_file" "mod1" {
  content     = "mod1 file test2"
  filename = "${path.module}/mod1.txt"
}

