
include "root" {
  path = find_in_parent_folders()
  expose = true
}

inputs = {
  content = include.root.locals.env_name

}