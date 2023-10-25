terraform {

  cloud {
    organization = "denis256"
    workspaces {
      project = "t256"
      name = "test-1"
    }
  }

}

resource "local_file" "file" {
content = "test"
filename = "txt.txt"
}
