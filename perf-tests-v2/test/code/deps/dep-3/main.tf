
variable "file_content" {}

output "vpc_id" {
  value = "666 ${var.file_content}"
}