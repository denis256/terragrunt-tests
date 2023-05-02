include {
  path   = find_in_parent_folders()
}

#dependencies {
#  paths = ["${get_repo_root()}/s3-race-conditions/project/common"]
#}

terraform {
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/file-2?ref=master"
}

inputs = {
  file_content = "test"
}


#dependency "common_dependency" {
#  config_path = "${get_repo_root()}/s3-race-conditions/project/common"
#
#  mock_outputs = {
#    vpc_id = "fake-vpc-id"
#  }
#}