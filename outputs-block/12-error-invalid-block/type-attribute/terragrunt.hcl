outputs {
  output "vpc_id" {
    # The pilot has no type attribute: types come from the module.
    type       = "string"
    mock_value = "vpc-mock"
  }
}
