unit "enlist" {
  source = "${get_repo_root()}/stack-autoinclude-nested-dep-values/nested-fixed/catalog/units/enlist"
  path   = "unit_enlist"

  autoinclude {
    dependency "install" {
      config_path = values.install_path

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
