include "root" {
path = find_in_parent_folders()
}

include "overwrite" {
path = find_in_parent_folders("overwrite.hcl")
}

locals {
    app_var = run_cmd("echo", "app")
}