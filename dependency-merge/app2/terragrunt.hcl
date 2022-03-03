include "inputs" {
  path           = find_in_parent_folders("common.hcl")
  merge_strategy = "deep"
}

inputs = {
  bucket_policy_statements = {
    xxx = "yyy"
    abc = "123"
  }
}