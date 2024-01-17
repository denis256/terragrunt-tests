locals {
  cluster_common_config_path       = "terraform.tfvars"
  cluster_config_vars = merge(
    fileexists(local.cluster_common_config_path) ? jsondecode(read_tfvars_file(local.cluster_common_config_path)) : tomap({})
  )


  cluster_common_config_path2       = "terraform.tfvars.json"
  cluster_config_vars2 = merge(
    fileexists(local.cluster_common_config_path2) ? jsondecode(read_tfvars_file(local.cluster_common_config_path2)) : tomap({})
  )
}