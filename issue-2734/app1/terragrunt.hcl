dependency "example" {
  config_path = "/folder/" #this folder and path doesnt exist
  enabled = fileexists("/folder/terragrunt.hcl") #false
}

inputs = {
  example = try(dependency.example.outputs.test,null)
}
