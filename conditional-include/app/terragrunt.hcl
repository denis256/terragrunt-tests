
include "region" {
  path           = find_in_parent_folders("${local.file}")

}

locals {

  file = "a.hcl"
}