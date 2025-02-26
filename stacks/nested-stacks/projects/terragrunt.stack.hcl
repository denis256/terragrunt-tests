unit "backend" {
	source = "git::git@github.com:denis256/terragrunt-tests.git//project-backend?ref=master"
	path   = "backend-v1"
}

unit "frontend" {
	source = "git::git@github.com:denis256/terragrunt-tests.git//project-frontend?ref=master"
	path   = "frontend-v1"
}


