variable "ip_address" {
    type = string
}

variable "dns_a_record" {
    type = string
}

output "fqdn" {
    value = "${var.dns_a_record}.hello.world.example.com"
}