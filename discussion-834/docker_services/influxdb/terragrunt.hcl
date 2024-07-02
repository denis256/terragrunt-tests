include "common" {
    path = find_in_parent_folders("common.hcl")
}


inputs = {
  docker_service = dependency.docker_server.outputs.ip
}
