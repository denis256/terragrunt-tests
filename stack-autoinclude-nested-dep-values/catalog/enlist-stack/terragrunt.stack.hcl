# Nested stack (generated under live/.terragrunt-stack/enlist).
# Its unit references values.maas_url, but the top-level stack only passed `version`
# (maas_url was a dependency output, which cannot become a generate-time value).
unit "enlist" {
  source = "../units/enlist"
  path   = "unit_enlist"

  values = {
    version  = try(values.version, null)
    maas_url = values.maas_url
  }
}
