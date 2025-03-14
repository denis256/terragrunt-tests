unit "dev-unit-config" {
	source = "${get_repo_root()}/stacks-test/hidden/config/dev"
	path   = "dev-unit-config"
	hidden = true
}

unit "dev-api" {
	source = "${get_repo_root()}/stacks-test/hidden/units/api"
	path   = "api"
	values = {
		ver = "dev-api 1.0.0"
	}
}

unit "dev-db" {
	source = "${get_repo_root()}/stacks-test/hidden/units/db"
	path   = "db"
	values = {
		ver = "dev-db 1.0.0"
	}
}

unit "dev-web" {
	source = "${get_repo_root()}/stacks-test/hidden/units/web"
	path   = "web"
	values = {
		ver = "dev-web 1.0.0"
	}
}
