# Top-level stack. It tries to feed a dependency's OUTPUT down into a nested stack
# by putting a dependency + inputs in an autoinclude on the `stack` block.
#
# This does not work: dependency outputs are run-time data, while a nested stack's
# `values` are resolved at generate time. A stack file also has no `inputs` to consume.
stack "enlist" {
  source = "../catalog/enlist-stack"
  path   = "enlist"

  autoinclude {
    dependency "install" {
      config_path = "../install"

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

  values = {
    version = "v1"
  }
}
