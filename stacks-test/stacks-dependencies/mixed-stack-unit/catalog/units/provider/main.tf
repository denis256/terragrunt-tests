resource "local_file" "marker" {
  content  = "Hello from provider in stack foo!"
  filename = "${path.module}/output.txt"
}

output "val" {
  value = "from-stack-foo"
}
