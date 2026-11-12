outputs {
  mock_strategy {
    allowed_commands = ["validate", "plan"]
    merge_with_state = "shallow"
  }

  output "vpc_id" {
    mock_value = "vpc-mock"
  }

  # Declared before the module exports it. shallow fills it from mock_value
  # until vpc is applied with a module that has the output.
  output "nat_id" {
    mock_value = "nat-mock"
  }
}
