dependency "external_ebs_key_2024" {
  config_path = "../kms/external-ebs-key-2024"
}

inputs = {
  data = dependency.external_ebs_key_2024.outputs.qwe
}