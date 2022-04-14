resource "local_file" "mock_work" {
  content     = "Creating K3S cluster + firewall_id"
  filename = "${path.module}/mock_work.txt"
}

output "firewall_id" {
  value = local_file.mock_work
}