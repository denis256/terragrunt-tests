locals {
  l1 = run_cmd("echo", "1")
  l2 = "2"
}

inputs = {
  i1 = local.l1,
  i2 = local.l2,
}