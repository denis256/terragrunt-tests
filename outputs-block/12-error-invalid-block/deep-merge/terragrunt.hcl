outputs {
  mock_strategy {
    # deep is not a mock merge strategy; only no_merge, shallow, deep_map_only are.
    merge_with_state = "deep"
  }

  output "vpc_id" {
    mock_value = "vpc-mock"
  }
}
