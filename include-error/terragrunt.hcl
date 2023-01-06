locals {
  source_base_url = "test"
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  name_prefix = local.common_vars.locals.name_prefix
  name = "${basename(get_original_terragrunt_dir())}"
  account_id = basename(local.common_vars.locals.map1["key1"])
  qwe = local.common_vars.locals.x * 10000
  ami_id_map = {
    "us-west-2" = "123"
  }

  region_vars = read_terragrunt_config("test.hcl")


  region = "us-east-1"

  foo = [
    merge(
      { region = local.region },
      { qwe = 1 },
    )
  ]

  x = 1
  y = 0
  z = local.x * local.y

  qwe1 = dynamic  qwe {
    for_each = local.foo
    content = {
      region = local.region
      qwe = 1
    }
  }

  }

}

inputs = {
  cluster_version = "1.23"
}
