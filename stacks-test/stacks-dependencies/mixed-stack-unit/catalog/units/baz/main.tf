resource "local_file" "marker" {
  content  = "Hello from sibling unit baz!"
  filename = "${path.module}/output.txt"
}

output "val" {
  value = "from-sibling-baz"
}
