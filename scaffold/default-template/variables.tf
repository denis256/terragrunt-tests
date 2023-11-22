variable "project_name" {

  description = "Project name"

}

variable "test_1" {}

variable "test_2" {
  default = {
    x = 1
  }
}

variable "test_3" {
  type = integer
  default = 666
  description = "description test 3"
}