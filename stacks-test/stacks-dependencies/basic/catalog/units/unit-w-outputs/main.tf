# Unit that produces outputs for other units to consume.
# This simulates a VPC or database module that other modules depend on.

resource "local_file" "output_marker" {
  content  = "Hello from unit-w-outputs!"
  filename = "${path.module}/output.txt"
}

output "val" {
  value = "Hello!"
}

output "id" {
  value = "unit-w-outputs-12345"
}
