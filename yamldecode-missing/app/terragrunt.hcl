inputs = merge(
  yamldecode(file("${find_in_parent_folders("secrets.yaml")}")),
  yamldecode(file("${find_in_parent_folders("region.yaml")}"))
)