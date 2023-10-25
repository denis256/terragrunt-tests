generate "backend" {
  path      = "backend.tf"
  if_exists = "skip"
  contents  = <<EOF
terraform {

  cloud {
    organization = "denis256"
    workspaces {
      project = "t256-2-tg"
      name = "test-3-tg"
    }
  }
}
EOF
}