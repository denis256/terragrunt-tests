locals {

  docker_service = {
    server = "server1"
  }


}
dependency "docker_server" {
  config_path = "${get_terragrunt_dir()}/../../modules/docker_servers/${local.docker_service.server}"
}

