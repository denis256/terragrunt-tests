errors {
  ignore "failing-dep-error" {
    ignorable_errors = [
      ".*Script error.*",
    ]
    message = "Ignoring error example1"
  }
}