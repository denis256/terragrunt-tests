terraform {
  backend "s3" {}
}

resource "local_file" "file" {
  content     = " file "
  filename = "${path.module}/cluster_name.txt"
}

output "file_name" {
  value = local_file.file.filename
}

variable "region" {
  default = "af-south-1"
}

variable "vpc_cidr_block" {
  default =  "10.1.0.0/16"
}


variable "vpc_enable_dns_hostnames" {
  default = true
}

variable "vpc_enable_dns_support" {
  default = true
}

variable "vpc_name" {
  default = "test"
}

variable "vpc_id" {
  default = "vpc-cd9d5629"
}

data "external" "region" {
  program = ["bash", "-c", "echo '{\"value\":\"${var.region}\"}'"]
}

data "external" "vpc_cidr_block" {
  program = ["bash", "-c", "echo '{\"value\":\"${var.vpc_cidr_block}\"}'"]
}

data "external" "vpc_enable_dns_hostnames" {
  program = ["bash", "-c", "echo '{\"value\":\"${var.vpc_enable_dns_hostnames}\"}'"]
}

data "external" "vpc_enable_dns_support" {
  program = ["bash", "-c", "echo '{\"value\":\"${var.vpc_enable_dns_support}\"}'"]
}

data "external" "vpc_id" {
  program = ["bash", "-c", "echo '{\"value\":\"${var.vpc_id}\"}'"]
}

data "external" "vpc_name" {
  program = ["bash", "-c", "echo '{\"value\":\"${var.vpc_name}\"}'"]
}

output "region" {
  value = data.external.region.result["value"]
}

output "vpc_cidr_block" {
  value = data.external.vpc_cidr_block.result["value"]
}

output "vpc_enable_dns_hostnames" {
  value = data.external.vpc_enable_dns_hostnames.result["value"]
}
output "vpc_enable_dns_support" {
  value = data.external.vpc_enable_dns_support.result["value"]
}

output "vpc_id" {
  value = data.external.vpc_id.result["value"]
}

output "vpc_name" {
  value = data.external.vpc_name.result["value"]
}

