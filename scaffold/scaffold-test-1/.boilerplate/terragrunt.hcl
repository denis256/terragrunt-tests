
inputs = {

  project_name = "{{ .project_name }}"
  description = "{{ .description }}"

  {{range .parsedInputs}}
  {{.}} = ""
  {{end}}
}
