dependency "eks_cluster" {
  config_path = "../eks_cluster"
}

dependency "kms_key_2024" {
  config_path = "../kms_key_2024"
}

inputs = {
  provider_url           = dependency.eks_cluster.outputs.cluster_oidc_issuer_url
  kms_keys_for_ebs_csi   = [dependency.kms_key_2024.outputs.arn]
}