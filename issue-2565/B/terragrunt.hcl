terraform {
  source = "./"
}
dependency "A" {
  config_path = "../A"
}
