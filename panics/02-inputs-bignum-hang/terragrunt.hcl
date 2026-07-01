# Reproduces a hang when a huge-exponent number literal is serialized.
# 9E9999999 forces go-cty to materialize a decimal with millions of digits.
# The hang happens when the config is rendered, no OpenTofu required.
#
# Run: terragrunt render

terraform {
  source = "."
}

inputs = {
  count = 9E9999999
}
