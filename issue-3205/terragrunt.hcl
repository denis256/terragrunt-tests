inputs = {
  access_policies = [
    {
      object_ids          = ["xyz", "abc"],
      secret_permissions = ["Get", "Set"],
      key_permissions    = ["Get"]
    },
    {
      object_ids          = ["3cm"],
      secret_permissions = ["Get"],
      key_permissions    = ["Get"]
    }
  ]
}