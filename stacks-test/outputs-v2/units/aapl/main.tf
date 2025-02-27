output "ticker" {
  value = "aapl"
}

output "ytd" {
  value = 4.01
}

output "provider" {
  value = {
    "name" = "yahoo"
    "url" = "https://finance.yahoo.com/quote/AAPL"
    timetamp = timestamp()
    id = 666
    delta = 0.01
  }
}


resource "local_file" "config" {
  content     = " file"
  filename = "${path.module}/config.txt"
}

output "config" {
  value = local_file.config.filename
}
