unit "project-1-app1" {
	source = "../units/app1"
	path   = "project-1-app1"
}

unit "project-1-app2" {
	source = "../units/app2"
	path   = "project-1-app2"
}


stack "stack1" {
	source = "${get_repo_root()}/stacks/stack-in-stack/units/app3"
	path = "stack1"
}
