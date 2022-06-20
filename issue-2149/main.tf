terraform {
  backend "gcs" {}
}

resource "local_file" "mock_work" {
  content     = "Mock file"
  filename = "${path.module}/mock_work.txt"
}
