resource "local_file" "policy" {
  for_each = {
    for policy in flatten([
      for p in var.access_policies : [
        for id in p.object_ids : {
          id = id
          secret_permissions = p.secret_permissions
          key_permissions = p.key_permissions
        }
      ]
    ]) : policy.id => policy
  }

  filename = "${path.module}/policies/policy_${each.key}.json"
  content = jsonencode({
    object_id = each.key
    secret_permissions = each.value.secret_permissions
    key_permissions = each.value.key_permissions
  })
}