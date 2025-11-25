unit "unita-dev-a" {
  source = "../units/unit"
  path   = "unita-dev-a"
}

unit "unita-dev-b" {
  source = "../units/unit"
  path   = "unita-dev-b"
}


exclude { # former skip=true|false
  if = true # Boolean to determine exclusion.
  no_run=true # Boolean to prevent the unit from running (even when not using `--all`).
  actions = [ # List of actions to exclude (e.g., "plan", "apply", "all", "all_except_output").
    "all",
    # "all_except_output",
    # "plan",
    # "apply",
    # "destroy",
    ]
}