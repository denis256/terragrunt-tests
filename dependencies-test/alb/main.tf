output result {

  value = "42"
}

resource "local_file" "file" {
  content     = " file"
  filename = "cluster_name-1.txt"
}
