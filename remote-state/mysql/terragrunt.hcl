
include "root" {
  path = find_in_parent_folders()
}

#include "another_s3" {
#  path = "../another-s3/terragrunt.hcl"
#}

