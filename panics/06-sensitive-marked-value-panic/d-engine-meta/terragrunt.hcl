# Same sensitive() mark bug, reached when render serializes engine.meta.
#
# Run: terragrunt render

engine {
  source = "x"
  meta = {
    secret = sensitive("hunter2")
  }
}
