stack "enlist" {
  source = "../catalog/simple-stack"
  path   = "enlist"

  autoinclude {
    unit "enlist" {
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
  }
}
