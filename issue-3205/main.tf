variable "access_policies" {
  type = list(
    object({
      object_id = list(string),
      secret_permissions = list(string),
      key_permissions = list(string)
    })
  )
}

locals {
  processed_access_policies = [
    for policy in var.access_policies : {
      object_ids = [for id in policy.object_id : id]
      secret_permissions = policy.secret_permissions
      key_permissions = policy.key_permissions
    }
  ]
}

output "processed_access_policies" {
  value = local.processed_access_policies
}