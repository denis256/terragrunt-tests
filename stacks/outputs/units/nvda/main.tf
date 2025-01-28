output "ticker" {
  value = "nvda"
}

output "ytd" {
  value = 6.77
}

output "price" {
  value = -666
}

resource "local_file" "config" {
  content     = " file"
  filename = "${path.module}/config.txt"
}

output "config" {
  value = local_file.config.filename
}
