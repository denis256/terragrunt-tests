include "common" {
  path   = find_in_parent_folders()
}

dependencies {
  paths = ["${get_repo_root()}/s3-race-conditions/project/common"]
}

#dependency "common_dependency" {
#  config_path = "${get_repo_root()}/s3-race-conditions/project/common"
#
#  mock_outputs = {
#    vpc_id = "fake-vpc-id"
#  }
#}