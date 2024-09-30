include {
  path = find_in_parent_folders("provider.hcl")
}

inputs = {
  vpc_name = "test1"
}
