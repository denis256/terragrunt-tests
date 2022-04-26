

resource "local_file" "pass_file" {
  content     = "Pass file"
  filename = "${path.module}/pass_file.txt"
}
