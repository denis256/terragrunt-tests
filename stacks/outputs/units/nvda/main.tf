output "ticker" {
  value = "nvda"
}

output "ytd" {
  value = 6.77
}

output "price" {
  value = -666
}

output "provider" {
  value = {
    "name" = "yahoo"
    "url" = "https://finance.yahoo.com/quote/NVDA"
    timetamp = timestamp()
    id = 777
    delta = 0.02
  }
}

resource "local_file" "config" {
  content     = " file"
  filename = "${path.module}/config.txt"
}

output "config" {
  value = local_file.config.filename
}
