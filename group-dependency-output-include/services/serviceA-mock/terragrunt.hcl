include "unique_id" {
  path   = find_in_parent_folders("unique-id.hcl")
  merge_strategy = "deep"
}

inputs = {
  unique_id = dependency.unique_id.outputs.id

}