terraform {
  source = "git::git@github.com:aws-ia/terraform-aws-eks-blueprints.git//modules/kubernetes-addons?ref=v4.6.1"
}

locals {
  # Extract needed variables for reuse
  cluster_version = "1.22"
  name =  "test1"
  create_eks = "false"
}

dependency "eks" {
  config_path = "../eks"

  #mock_outputs_allowed_terraform_commands = ["validate"]

  mock_outputs = {
    eks_cluster_endpoint = "https://000000000000.gr7.eu-west-3.eks.amazonaws.com"
    eks_oidc_provider = "something"
    eks_cluster_id = "something"
    create_eks = "false"
  }
}

inputs = {
  eks_cluster_id = dependency.eks.outputs.eks_cluster_id
  create_eks = dependency.eks.outputs.create_eks

  eks_cluster_endpoint = dependency.eks.outputs.eks_cluster_endpoint
  eks_oidc_provider = dependency.eks.outputs.eks_oidc_provider
  eks_cluster_version = local.cluster_version

}