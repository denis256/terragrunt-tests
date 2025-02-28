unit "prod-api" {
	source = "${get_repo_root()}/stack-one-level/stack/api"
	path   = "api"
	values = {
		data = "prod-api 1.0.0"
	}
}
