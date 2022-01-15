module "date" {
  source = "git@github.com:denis256/terraform-test-module.git//modules/date?ref=v0.0.5"
}

output "date" {
  value = module.date
}