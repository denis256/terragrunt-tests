# Reproduces a hang when a huge-exponent number is decoded into the string-typed
# terraform.source field. The number-to-string conversion runs during config decode,
# so any command that loads the config hangs, no OpenTofu required.
#
# Run: terragrunt render   (or run, validate, hcl validate)

terraform {
  source = 9E9999999
}
