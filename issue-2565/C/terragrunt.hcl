terraform {
  source = "./"
}
dependency "B" {
  config_path = "../B"
}
