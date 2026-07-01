locals {
  env = values.env
}

unit "producer" {
  source = "${get_repo_root()}/6289/units/producer"
  path   = "producer-${local.env}"
}
