include "tf_module" {
  path = find_in_parent_folders("tf_module.hcl")
}
inputs = {
  file_name = "file1.txt"
  content  = "content of file1.txt"
}