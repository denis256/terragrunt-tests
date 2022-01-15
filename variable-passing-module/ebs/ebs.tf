variable "instance_id" {
  type = string
}

resource "local_file" "ebs_files" {
  content     = "Creating EBS for instance ${var.instance_id}"
  filename = "${path.module}/ebs.txt"
}