resource "local_file" "marker" {
  content  = "Hello from provider!"
  filename = "${path.module}/output.txt"
}

output "val" {
  value = "Hello-from-provider"
}
