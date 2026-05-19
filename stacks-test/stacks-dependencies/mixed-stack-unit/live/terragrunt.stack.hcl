locals {
  env = "test"
}

stack "foo" {
  source = "../catalog/stacks/foo"
  path   = "foo"
}

unit "baz" {
  source = "../catalog/units/baz"
  path   = "baz"
}

unit "bar" {
  source = "../catalog/units/bar"
  path   = "bar"

  autoinclude {
    dependency "provider" {
      config_path = stack.foo.provider.path

      mock_outputs_allowed_terraform_commands = ["validate", "plan"]
      mock_outputs = {
        val = "fake-from-stack"
      }
    }

    dependency "baz" {
      config_path = unit.baz.path

      mock_outputs_allowed_terraform_commands = ["validate", "plan"]
      mock_outputs = {
        val = "fake-from-unit"
      }
    }

    inputs = {
      val_from_stack = dependency.provider.outputs.val
      val_from_unit  = dependency.baz.outputs.val
    }
  }
}
