
resource "local_file" "ec2" {
  content     = "ecs for ${var.project_name} ${var.replica_count}"
  filename = "${path.module}/ec2.txt"
}
