module "date" {
  source = "git@github.com:denis256/terraform-test-module.git//modules/date?ref=v0.0.7"
}

output "instance_id" {
  value = module.date.date
}