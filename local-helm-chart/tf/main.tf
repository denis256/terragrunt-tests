
module "helm-module" {
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/helm-module?ref=master"
  enabled = true
}