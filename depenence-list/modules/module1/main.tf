resource "local_file" "module1" {
    content     = "module1"
    filename = "${path.module}/module1.txt"
}
