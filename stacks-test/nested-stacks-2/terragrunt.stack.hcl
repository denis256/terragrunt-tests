
stack "apps" {
  source = "git::git@github.com:denis256/test-terragrunt-stack.git?ref=master"
  path   = "apps"
}

unit "dev" {
  source = "./units/dev"
  path   = "dev"
}
