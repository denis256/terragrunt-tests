
terraform {
  source = "../../../../base"
}

locals {
  teams       = jsondecode(read_tfvars_file("../../../../teams.tfvars"))
  environment = jsondecode(read_tfvars_file("../../../../environments.tfvars.json"))
}

include {
  path = find_in_parent_folders("eng_teams.hcl")
}

// This line causes the crash
include {
  path = find_in_parent_folders("_envcommon.hcl")
}

inputs = merge(
  { environment = basename(dirname(get_terragrunt_dir())),
    app = {
      "kind"      = "deployment",
      "namespace" = "foobar",
      "slug"      = "barfoo"
    }
  },
  local.teams,
  local.environment
)
