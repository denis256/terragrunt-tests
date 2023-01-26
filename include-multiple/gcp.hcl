generate "gcp" {
  path      = "gcp.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "google" {
  region  = "us-central1"
}
EOF
}