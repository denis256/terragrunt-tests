dependency "external_ebs_key_2024" {
  config_path = "${get_repo_root()}/issue-2955/kms/external-ebs-key-2024"
}

inputs = {
  data = dependency.external_ebs_key_2024.outputs.qwe
}