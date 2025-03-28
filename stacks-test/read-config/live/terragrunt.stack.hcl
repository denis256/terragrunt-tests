locals {
	project = "root-stack-my-project"
}

unit "app1" {
	source = "../units/app"
	path   = "app1"

	values = {
		project    = local.project
		deployment = "app1"
		config = {
			"key1" = "value1"
			"key2" = "value2"
		}
	}
}

unit "app2" {
	source = "../units/app"
	path   = "app2"

	values = {
		project    = local.project
		deployment = "app2"
		config = {
			"key1" = "value3"
			"key2" = "value4s"
		}
	}
}

