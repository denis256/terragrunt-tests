

inputs = {
  access_policies = [
    {
      file               = "1.json"
      object_id          = toset(["xyz", "abc"]),
      secret_permissions = toset(["Get", "Set"]),
      key_permissions    = toset(["Get"])
    },
    {
      file               = "2.json"
      object_id          = toset(["666", "111"]),
      secret_permissions = toset(["Get"]),
      key_permissions    = toset(["Get"])
    }
  ]
}
