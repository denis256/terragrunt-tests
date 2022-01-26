resource "local_file" "foo" {
  content     = "local file"
  filename = "${path.module}/foo.bar"
}