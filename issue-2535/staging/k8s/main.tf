resource "local_file" "k8s" {
  content  = "k8s"
  filename = "${path.module}/k8s.txt"
}