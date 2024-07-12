variable "access_policies" {
  type = list(object({
    file               = string
    object_id          = set(string)
    secret_permissions = set(string)
    key_permissions    = set(string)
  }))
}

# Create local files for each policy
resource "local_file" "access_policies_files" {
  count    = length(var.access_policies)
  filename = var.access_policies[count.index].file
  content  = jsonencode(var.access_policies[count.index])
}
