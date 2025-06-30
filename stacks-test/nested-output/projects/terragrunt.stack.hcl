unit "backend" {
  source = "${get_repo_root()}/project-backend"
  path   = "backend-v1"
}

unit "frontend" {
  source = "${get_repo_root()}/project-frontend"
  path   = "frontend-v1"
}

stack "test_stack_v1" {
  source = "${get_repo_root()}/stacks-test/nested-output/stacks/v1"
  path   = "stacks1"
}

stack "test_stack_v2" {
  source = "${get_repo_root()}/stacks-test/nested-output/stacks/v2"
  path   = "stacks2"
}
