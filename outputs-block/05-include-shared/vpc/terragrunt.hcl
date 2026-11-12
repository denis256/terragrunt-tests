include "root" {
  path           = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

# deep: the mock_strategy of root.hcl plus these outputs.
outputs {
  output "vpc_id" {
    mock_value = "vpc-mock"
  }

  output "subnet_ids" {
    mock_value = ["subnet-mock-1", "subnet-mock-2"]
  }
}
