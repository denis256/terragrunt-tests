
```
terragrunt apply
```

Example output:
```
processed_access_policies = [
  {
    "key_permissions" = tolist([
      "Get",
    ])
    "object_ids" = [
      "xyz",
      "abc",
    ]
    "secret_permissions" = tolist([
      "Get",
      "Set",
    ])
  },
]

```