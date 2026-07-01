stack "dev" {
  source = "../stacks/child"
  path   = "dev"

  values = {
    env = "dev"
  }
}

unit "consumer" {
  source = "${get_repo_root()}/6289/units/consumer"
  path   = "consumer"

  autoinclude {
    dependency "dev" {
      config_path = stack.dev.path
    }

    inputs = {
      v = dependency.dev.outputs.producer.v
    }
  }
}
