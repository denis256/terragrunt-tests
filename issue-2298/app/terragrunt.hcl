

include {
  path = "${find_in_parent_folders()}"
}

dependency "cert" {
  config_path = "../certificate"
  mock_outputs = {
    this_certificate_arn = ""
  }
}

dependency "svc" {
  config_path = "../svc"
  mock_outputs = {
    this_certificate_arn = ""
  }
}