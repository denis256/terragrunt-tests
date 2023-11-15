
terraform {
  source = "."
}

inputs = {
  fileName = "{{.fileName}}"
}