# Parent config pulled in by the child via a deep include.
# It declares a dependency with the SAME label as the child ("d").
dependency "d" {
  config_path = "../somepath"
}
