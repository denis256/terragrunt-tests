# Same sensitive() mark bug, reached through the stack-file decoder.
#
# Run: terragrunt stack generate

unit "app" {
  source = sensitive("./app")
  path   = "app"
}
