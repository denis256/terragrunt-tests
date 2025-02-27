
stack "dev" {
	source = "${get_repo_root()}/stacks/nested-stacks-3/stacks/dev"
	path = "dev"
}


stack "prod" {
	source = "${get_repo_root()}/stacks/nested-stacks-3/stacks/dev"
	path = "prod"
}
