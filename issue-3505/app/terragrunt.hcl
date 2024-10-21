include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr:///RaJiska/fck-nat/aws?version=1.3.0"
  // source = "https://github.com/RaJiska/terraform-aws-fck-nat.git"
}