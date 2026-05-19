locals {
  env = "test"
}

stack "foo" {
  source = "../catalog/stacks/foo"
  path   = "foo"
}

unit "bar" {
  source = "../catalog/units/bar"
  path   = "bar"

  autoinclude {
    dependency "provider" {
      config_path = stack.foo.provider.path

      mock_outputs_allowed_terraform_commands = ["validate", "plan"]
      mock_outputs = {
        val = "fake-val"
      }
    }

    inputs = {
      val = dependency.provider.outputs.val
    }
  }
}
