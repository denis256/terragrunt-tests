unit "backend" {
  source = "${get_repo_root()}/project-backend"
  path   = "backend-v2"
}

stack "test_stack_v1" {
  source = "${get_repo_root()}/stacks-test/nested-output/stacks/v1"
  path   = "stacks2"
}

