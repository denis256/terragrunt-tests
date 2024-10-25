feature "boolean_feature_flag" {
  default = false
}

feature "string_feature_flag" {
  default = "test"
}

locals {
  greeting = run_cmd("echo", "string_feature_flag", feature.string_feature_flag.value)
}

inputs = {
  boolean_feature_flag = feature.boolean_feature_flag.value
  string_feature_flag = feature.string_feature_flag.value
}