
include "state" {
  path = find_in_parent_folders()
}

include "drone" {
  path = find_in_parent_folders("drone.hcl")
}

dependency "p2" {
  config_path = "../common"
//  skip_outputs = true
  mock_outputs_merge_strategy_with_state = "deep_map_only"

  /*
  mock_outputs = {
    user_passwords = "1"
  } */

}

inputs = {
  postgres_user     = "recsys"
  postgres_password = dependency.p2.outputs.user_passwords.x1
}


