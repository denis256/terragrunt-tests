
variable "content" {
  type = string
  default = "Default Content string"
}

resource "local_file" "app" {
  content     = var.content
  filename = "/tmp/app.txt"
}
