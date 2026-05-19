resource "local_file" "marker" {
  content  = "Hello from AWS provider!"
  filename = "${path.module}/output.txt"
}

output "val" {
  value = "aws-provider-val"
}
