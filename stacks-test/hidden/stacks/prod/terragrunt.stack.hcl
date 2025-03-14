unit "prod-unit-config" {
	source = "${get_repo_root()}/stacks-test/config/prod"
	path   = "prod-unit-config"
	hidden = true
}

unit "prod-api" {
	source = "${get_repo_root()}/stacks-test/units/api"
	path   = "api"
	values = {
		ver = "prod-api 1.0.0"
	}
}

unit "prod-db" {
	source = "${get_repo_root()}/stacks-test/units/db"
	path   = "db"
	values = {
		ver = "prod-db 1.0.0"
	}
}

unit "prod-web" {
	source = "${get_repo_root()}/stacks-test/units/web"
	path   = "web"
	values = {
		ver = "prod-web 1.0.0"
	}
}
