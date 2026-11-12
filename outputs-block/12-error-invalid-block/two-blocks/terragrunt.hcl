outputs {
  output "vpc_id" {
    mock_value = "vpc-mock"
  }
}

# Only one outputs block per unit.
outputs {
  output "subnet_ids" {
    mock_value = []
  }
}
