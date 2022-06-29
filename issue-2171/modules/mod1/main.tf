resource "local_file" "mod1" {
    content     = "mod1 file"
    filename = "${path.module}/mod1.txt"
}

resource "local_file" "mod2" {
    content     = "mod2 file"
    filename = "${path.module}/mod1.txt"
}

