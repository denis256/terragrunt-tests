# Reproduces a panic in the dependency deep-merge path.
# The child declares a dependency with the same label "d" as the parent, but
# with a NON-STRING config_path. Deep-merging the two dependency blocks reaches
# an unguarded AsString() call.
#
# Run: terragrunt hcl validate
# Note: this is intermittent (a goroutine race in dependency parsing). Run it a
# few times; it panics on most runs.

include "root" {
  path           = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

terraform {
  source = "."
}

dependency "d" {
  # Non-string config_path. A number, bool, list, or object all trigger it.
  config_path = true
}
