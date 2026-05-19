resource "local_file" "marker" {
  content  = "Hello from provider inside stack foo!"
  filename = "${path.module}/output.txt"
}

output "val" {
  value = "Hello-from-nested-provider"
}
