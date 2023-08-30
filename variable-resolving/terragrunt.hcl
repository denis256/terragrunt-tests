locals {

}

generate "service-accounts" {
  path = "service-accounts.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF


policy = {
"Version" : "2012-10-17",
"Statement" : jsonencode(${spec.Statement})
}

EOF
}