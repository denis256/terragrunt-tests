# Reproduces a hang when a huge-exponent number is decoded into a unit's string-typed
# source field. ReadStackConfigFile decodes the stack file with no experiment gate,
# so this hangs on a default install.
#
# Run: terragrunt stack generate

unit "x" {
  source = 9E9999999
  path   = "x"
}
