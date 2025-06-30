unit "backend" {
  // 	source = "git::git@github.com:denis256/terragrunt-tests.git//project-backend?ref=master"
  source = "${get_repo_root()}/project-backend"
  path   = "backend-v1"
}

unit "frontend" {
  // 	source = "git::git@github.com:denis256/terragrunt-tests.git//project-frontend?ref=master"
  source = "${get_repo_root()}/project-frontend"
  path   = "frontend-v1"
}


