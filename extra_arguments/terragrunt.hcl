terraform {
  // source = "."
#  extra_arguments "output_to_file" {
#    commands = ["output"]
#    arguments = [
#      "-json", ">", "${get_terragrunt_dir()}/output.json"
#    ]
#  }

  after_hook "after_hook" {
    commands     = ["output"]
    execute      = ["bash", "-c", "terraform output -json > ${get_terragrunt_dir()}/output.json"]
  }

}
