# VPC module
resource "local_file" "vpc" {
  content  = "vpc-config"
  filename = "${path.module}/vpc.txt"
}

output "vpc_id" {
  value = "vpc-12345"
}
