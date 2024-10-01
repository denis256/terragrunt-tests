terraform {
  source = "."
}

dependency "data1" {
  config_path = "../data1"
}


dependency "data2" {
  config_path = "../data2"
}

dependency "data3" {
  config_path = "../data3"
}

inputs = {
    data1_data1 = dependency.data1.outputs.data1
    data1_data2 = dependency.data1.outputs.data2
    data2_data1 = dependency.data2.outputs.data1
    data2_data2 = dependency.data2.outputs.data2
}