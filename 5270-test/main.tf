variable "dep_output" {
  type    = string
  default = ""
}

output "outputX" {
  value = "Output from x, dep says: ${var.dep_output}"
}
