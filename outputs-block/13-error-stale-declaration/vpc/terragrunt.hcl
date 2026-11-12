outputs {
  mock_strategy {
    allowed_commands = ["validate", "plan"]
  }

  output "vpc_id" {
    mock_value = "vpc-mock"
  }

  # Declared, but the applied module has no nat_id output and no
  # merge_with_state fills it from the mock.
  output "nat_id" {
    mock_value = "nat-mock"
  }
}
