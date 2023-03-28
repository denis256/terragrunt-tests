include {
  path = find_in_parent_folders()
}

locals {
  module_name = "modb"

  values = merge(
    yamldecode(file(find_in_parent_folders("global.yaml"))),
    yamldecode(file("variables.yaml")),
  )
}

dependency "moda" {
  config_path = "../moda"
}

dependencies {
  paths = ["../moda"]
}

terraform {
  source = "${local.values.tf_repo_pfx}-${local.module_name}?ref=${local.values.module_branch}"
}