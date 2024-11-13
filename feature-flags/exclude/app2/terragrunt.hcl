
feature "feature_name"{
  default = true
}

exclude {
  if = feature.feature_name.value # Boolean expression that determines if the node should be excluded.
  actions = ["apply"] # Actions to exclude when active. Other options might be ["plan", "apply", "all_except_output"], etc
  exclude_dependencies = feature.feature_name.value # Exclude dependencies of the node as well
}

