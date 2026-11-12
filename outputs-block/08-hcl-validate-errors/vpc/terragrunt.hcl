outputs {
  output "vpc_id" {
    mock_value = "vpc-mock"
  }

  # Stale: the module has no nat_id output.
  output "nat_id" {
    mock_value = "nat-mock"
  }
}
