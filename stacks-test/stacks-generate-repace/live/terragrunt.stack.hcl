unit "first" {
  source = "../units/multi-provider-units"
  path   = "first"
  values = {
    provider = "alpha"
  }
}

unit "second" {
  source = "../units/multi-provider-units"
  path   = "second"
  values = {
    provider = "beta"
  }
}