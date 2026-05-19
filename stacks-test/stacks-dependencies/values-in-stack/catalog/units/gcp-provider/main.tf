resource "local_file" "marker" {
  content  = "Hello from GCP provider!"
  filename = "${path.module}/output.txt"
}

output "val" {
  value = "gcp-provider-val"
}
