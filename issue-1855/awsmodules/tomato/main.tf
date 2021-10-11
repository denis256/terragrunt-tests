
resource "local_file" "local_file" {
    content     = "Local work done by module"
    filename = "${path.module}/work.txt"
}

output "test_value" {
  value = {
    tomato = 666
  }
}
