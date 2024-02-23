dependency "v2" {
    config_path = "../external-ebs-key-2024-v2"
}

inputs = {
    data = dependency.v2.outputs.qwe
}