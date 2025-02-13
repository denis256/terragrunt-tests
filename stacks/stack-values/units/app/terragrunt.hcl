
locals {
  data = "payload: ${unit.values.deployment}-${unit.values.project}"
}

inputs = {
  data = local.data
}