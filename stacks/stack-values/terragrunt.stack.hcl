unit "app1" {
	source = "units/app"
	path   = "app1"

	values = {
		deployment = "app1"
	}
}

unit "app2" {
	source = "units/app"
	path   = "app2"

	values = {
		deployment = "app2"
	}
}

