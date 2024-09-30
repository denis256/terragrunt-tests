include {
  path = find_in_parent_folders("provider.hcl")
}

inputs = {
  db_name = "department_b_rds"
}
