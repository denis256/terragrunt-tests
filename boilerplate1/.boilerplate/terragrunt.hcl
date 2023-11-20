
inputs = {

  project_name = {{ .project_name }}

  {{range .parsedInputs}}
  {{.}} = ""
  {{end}}
}
