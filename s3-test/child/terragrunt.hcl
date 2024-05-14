include "root" {
  path   = find_in_parent_folders()
}

inputs = {
  remote_state_config = include.root.remote_state
}
