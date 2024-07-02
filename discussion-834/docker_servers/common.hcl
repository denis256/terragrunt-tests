locals {

  docker_service = {
    server = "influxdb"
  }


}
dependency "docker_server" {
  config_path = "${get_terragrunt_dir()}/../../docker_services//${local.docker_service.server}"
}

