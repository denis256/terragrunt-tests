variable "aft_vpc_endpoints" {
  type        = bool
  description = "Flag turning VPC endpoints on/off for AFT VPC"
  default     = true
  validation {
    condition     = contains([true, false], var.aft_vpc_endpoints)
    error_message = "Valid values for var: aft_vpc_endpoints are (true, false)."
  }
}