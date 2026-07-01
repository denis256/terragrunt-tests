# The fix: the dependency and the consumption of its OUTPUTS live on the UNIT's
# autoinclude, where outputs resolve at the unit's run time. Stack-level data that is
# known at generate time (paths, versions) is what flows via `values`.
unit "enlist" {
  source = "../catalog/units/enlist"
  path   = "unit_enlist"

  autoinclude {
    dependency "install" {
      config_path = "../../../install"

      mock_outputs = {
        deploy = {
          url = "mock-url"
        }
      }
    }

    inputs = {
      maas_url = dependency.install.outputs.deploy.url
    }
  }
}
