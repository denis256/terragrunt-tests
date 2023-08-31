terraform {
  backend "gcs" {
    bucket  = "tf-test-2023-08-1"
  }
}

output "variable" {
  value = "42"
}