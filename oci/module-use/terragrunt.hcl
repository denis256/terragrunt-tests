locals {
  registry  = get_env("OCI_REGISTRY", "docker.io")
  namespace = get_env("OCI_NAMESPACE", "denis256")
  version   = get_env("OCI_VERSION", "1.0.0")
}

terraform {
  source = "oci://${local.registry}/${local.namespace}/terragrunt-oci-hello-module?tag=${local.version}"
}

inputs = {
  name = try(values.name, "Docker Hub")
}
