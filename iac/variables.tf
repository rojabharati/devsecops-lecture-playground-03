variable "ami" {
  type        = string
  description = "Amazon Machine Image ID"
}

variable "cidr" {
  type        = string
  description = "IP address range allowed in security group"
}