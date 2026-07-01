# Minimal module so the unit would be loadable. Not reached: the hang occurs while
# decoding the stack file, before any unit is generated.
output "x" {
  value = "ok"
}
