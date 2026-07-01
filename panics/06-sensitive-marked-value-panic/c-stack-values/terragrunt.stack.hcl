# Same sensitive() mark bug, reached through the unit values writer (hclwrite).
#
# Run: terragrunt stack generate

unit "app" {
  source = "./app"
  path   = "app"
  values = {
    secret = sensitive("hunter2")
  }
}
