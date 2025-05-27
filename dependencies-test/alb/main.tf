output result {

  value = "42"
}

resource "local_file" "file" {
  content     = " file 1"
  filename = "cluster_name-1.txt"
}
