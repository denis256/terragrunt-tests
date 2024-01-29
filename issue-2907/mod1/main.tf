output "result42" {
  value = "42"
}

resource "local_file" "mod1" {
  content     = "mod1"
  filename = "${path.module}/mod1.txt"
}

output "mod1" {
  value = "${local_file.mod1.filename}"
}

output "mod2" {
  value = 666
}

output "mod3" {
  value = false
}

output "mod4" {
  value = { "a" = "b" }
}