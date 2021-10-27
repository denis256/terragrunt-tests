include {
name = "root"
path = find_in_parent_folders()
}

include {
name = "overwrite"
path = find_in_parent_folders("overwrite.hcl")
}