resource "local_file" "foo" {
  filename = "${path.module}/terraform.txt"
  content  = <<-EOF
    terraform {
      required_version = ">= 1.3.0"
    }
    EOF
}