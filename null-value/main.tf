variable i1 {}

variable d1 {}

output o1 {
  value = var.i1
}

output o2 {
  value = var.d1
}

output "o3" {
  value = "o3"
}

resource "local_file" "file" {
  content     = " i1 ${var.d1} d1 "
  filename = "${path.module}/file-txt.txt"
}
