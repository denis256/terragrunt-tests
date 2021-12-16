resource "local_file" "common_file" {
    content     = "common file"
    filename = "${path.module}/common-file.txt"
}