include "backend_configuration" {
  path = find_in_parent_folders("backend_configuration.hcl")
}

include "environment_variables" {
  path = find_in_parent_folders("environment_variables.hcl")
}

