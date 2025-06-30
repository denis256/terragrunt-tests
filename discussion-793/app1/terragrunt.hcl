include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "blah" {
  config_path  = "${include.root.locals.config_path}"
  skip_outputs = true
}