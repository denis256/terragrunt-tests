include "root" {
  path = find_in_parent_folders("root.hcl")
}

# shallow (the default): this block replaces the one from root.hcl entirely,
# so db has no allowed_commands restriction.
outputs {
  output "db_url" {
    mock_value = "postgres://db-mock:5432/app"
  }
}
