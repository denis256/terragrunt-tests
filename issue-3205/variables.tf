variable "access_policies" {
  type = list(object({
    object_ids          = list(string),    # Changed from object_id to object_ids and set to list
    secret_permissions = list(string),    # Changed from set to list
    key_permissions    = list(string)     # Changed from set to list
  }))
}