
variable "pass" {

  sensitive = true

}

resource "local_file" "pass_file" {
  content     = "Pass file: ${var.pass}"
  filename = "${path.module}/pass_file.txt"
}

output "v1" {
  value = "v1"
}
