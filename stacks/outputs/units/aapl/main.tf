output "ticker" {
  value = "aapl"
}

output "ytd" {
  value = 4.01
}

resource "local_file" "config" {
  content     = " file"
  filename = "${path.module}/config.txt"
}

output "config" {
  value = local_file.config.filename
}
