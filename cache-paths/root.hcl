# Copy entire tree to cache, cd into the project subdirectory.
# This preserves ../../modules/... relative paths in .tf files.
terraform {
  source = "${get_terragrunt_dir()}/../..///${path_relative_to_include()}"
}
