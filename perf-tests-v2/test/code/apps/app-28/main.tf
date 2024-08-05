variable "file_content" {}

variable "dep_1" {}

variable "dep_2" {}

variable "dep_3" {}
variable "dep_4" {}
variable "dep_5" {}

output "result" {
  value = {
    file_content = var.file_content
    dep_1 = var.dep_1
    dep_2 = var.dep_2
    dep_3 = var.dep_3
    dep_4 = var.dep_4
    dep_5 = var.dep_5
  }
}