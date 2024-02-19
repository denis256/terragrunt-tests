dependency "foo" {
  config_path = find_in_parent_folders("foo/test")
  skip_outputs = "true"
}