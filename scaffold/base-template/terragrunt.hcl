# Base template to be used in different projects
terraform {
  source = "{{ .sourceUrl }}{{if .Ref}}?ref={{.Ref}}{{end}}"
}

inputs = {
  project_name = "template"
  test_1 = "test"
}