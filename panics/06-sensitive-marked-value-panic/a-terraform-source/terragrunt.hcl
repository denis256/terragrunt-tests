# Wrapping a string attribute in sensitive() marks the cty value.
# Terragrunt decodes it with gohcl without unmarking first, so it panics.
#
# Run: terragrunt render

terraform {
  source = sensitive(".")
}
