include "aws" {
  path   = find_in_parent_folders("aws.hcl")
}

include "gcp" {
  path   = find_in_parent_folders("gcp.hcl")
}