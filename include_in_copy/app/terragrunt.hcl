terraform {
    source = "${get_terragrunt_dir()}/../_module"
    include_in_copy = [ ".region2", "**/app2", "**/.include-me-too", "**/f0-3-levels.txt"]
}