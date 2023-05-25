variable "data1" {
  type = string
}

variable "data2" {
  type = string
}


resource "local_file" "provider_file" {
  content         = "data1  ${var.data1}  data2: ${var.data2}"
  filename        = "data.txt"
  file_permission = "0644"
}
