
feature "string_feature_flag" {
  default = "test"
}

feature "int_feature_flag" {
  default = 666
}

locals {
  string_feature_flag = run_cmd("echo", "string_feature_flag", feature.string_feature_flag.value)
  int_feature_flag    = run_cmd("echo", "int_feature_flag", feature.int_feature_flag.value)
}


inputs = {
  string_feature_flag = feature.string_feature_flag.value
  int_feature_flag    = feature.int_feature_flag.value
}