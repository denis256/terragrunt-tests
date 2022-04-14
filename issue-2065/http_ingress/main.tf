
variable "firewall_id" {}

variable "allowed_http_ips" {}

resource "local_file" "mock_work" {
  content     = "Here should be executed civo_firewall_rule with ${var.firewall_id} ${var.allowed_http_ips}"
  filename = "${path.module}/mock_work.txt"
}


#resource "civo_firewall_rule" "http_ingress" {
#  firewall_id = module.k3s_test_dev_fra1.firewall_id
#  action      = "allow"
#  protocol    = "tcp"
#  start_port  = "80"
#  end_port    = "80"
#  cidr        = var.allowed_http_ips
#  direction   = "ingress"
#  label       = "Web Ingress - HTTP"
#}