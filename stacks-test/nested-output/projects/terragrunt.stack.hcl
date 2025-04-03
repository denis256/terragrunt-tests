unit "backend" {
	source = "${get_repo_root()}/project-backend"
	path   = "backend-v1"
}

unit "frontend" {
	source = "${get_repo_root()}/project-frontend"
	path   = "frontend-v1"
}

stack "test_stack" {
	source = "${get_repo_root()}/stacks-test/nested-output/stacks"
	path   = "stacks1"
}
