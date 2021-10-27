resource "local_file" "foo" {
    content     = "dummy action"
    filename = "${path.module}/test.txt"
}
