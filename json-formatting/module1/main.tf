variable "list" {
  type = list(string)
  default = [ "abc", "123", "000"]
}
output "outlist" {
  value = var.list
}