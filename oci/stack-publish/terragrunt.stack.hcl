locals {
  registry  = get_env("OCI_REGISTRY", "docker.io")
  namespace = get_env("OCI_NAMESPACE", "denis256")
  version   = get_env("OCI_VERSION", "1.0.0")
}

unit "hello" {
  source = "oci://${local.registry}/${local.namespace}/terragrunt-oci-hello-unit?tag=${local.version}"
  path   = "hello"

  values = {
    name = "OCI stack"
  }
}
