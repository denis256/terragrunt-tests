# Base template to be used in different projects
terraform {
  source = "{{ .sourceUrl }}"
}

inputs = {
  project_name = "template"
  test_1 = "test"
}