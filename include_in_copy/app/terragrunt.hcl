terraform {
    source = "${get_terragrunt_dir()}/../_module"
    include_in_copy = [".f0", ".f1", ".f2"]
}