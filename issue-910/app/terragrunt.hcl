#include {
#  path = find_in_parent_folders()
#}

terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-security-group.git//modules/postgres?ref=v3.1.0"
}

#dependency "vpc" {
#  config_path = "../vpc"
#  mock_outputs = {
#    id = "mock_vpc_id"
#  }
#}
#
#dependency "metadata" {
#  config_path = "../metadata"
#  mock_outputs = {
#    tags = { "mock_metadata_tags" : "tags" }
#  }
#}
#
#inputs = {
#  vpc_id              = dependency.vpc.outputs.id
#  ingress_cidr_blocks = dependency.vpc.outputs.private_subnets_cidr_blocks
#  description         = "Postgres (5432) from private subnets"
#  name                = "${dependency.metadata.outputs.fqn}-postgres-vpc-private"
#  tags                = dependency.metadata.outputs.tags
#}