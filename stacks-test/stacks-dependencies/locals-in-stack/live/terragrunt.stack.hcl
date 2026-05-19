locals {
  env          = "test"
  stack_source = "../catalog/stacks/foo"
  consumer_src = "../catalog/units/consumer"
  stack_path   = "foo"
  mock_val     = "mock-${local.env}"
}

stack "foo" {
  source = local.stack_source
  path   = local.stack_path
}

unit "consumer" {
  source = local.consumer_src
  path   = "consumer"

  autoinclude {
    dependency "provider" {
      config_path = stack.foo.provider.path

      mock_outputs_allowed_terraform_commands = ["validate", "plan"]
      mock_outputs = {
        val = local.mock_val
      }
    }

    inputs = {
      env = local.env
      val = dependency.provider.outputs.val
    }
  }
}
