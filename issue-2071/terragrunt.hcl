locals {
  prefix = "myprefix-"
  complex = {
    foo = 1
    bar = {
      baz = "batz"
    }
  }
}

generate "locals" {
  if_exists = "overwrite"
  path      = "qwe.tf"
  contents = <<-EOF
    locals {
      complex1 = ${jsonencode(local.complex)}
    }


    resource "local_file" "file" {
      content     = "foo: $${local.complex1.foo}  bar: $${local.complex1.bar.baz}"
      filename = "app.txt"
    }
    EOF
}