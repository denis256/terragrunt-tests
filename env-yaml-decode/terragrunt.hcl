locals {
  cluster = yamldecode(file(get_env("CONFIG", "conf1.yaml")))
  test    = run_cmd("echo", jsonencode(local.cluster))
}