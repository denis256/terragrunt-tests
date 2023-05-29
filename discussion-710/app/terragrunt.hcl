include "root" {
  path = find_in_parent_folders()
}

dependency "module1" {
  config_path = "../module1"
  skip_outputs = true
}

dependency "module2" {
  config_path = "../module2"
  skip_outputs = true

}

dependency "module3" {
  config_path = "../module3"
  skip_outputs = true

}

dependency "module4" {
  config_path = "../module4"
  skip_outputs = true

}
