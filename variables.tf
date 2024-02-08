variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map('BusinessUnit`,`XYZ`)"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Enable/disable module."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for resoures."
}

variable "vpc_name" {
    description = "Name of the VPC"
}

variable "subnet_id" {
    description = "Ssubnet to place resources"
}

variable "region" {
    description = "Region"
}
variable "sg_tls_group_id" {
    description = "TLS security group ID"
}

variable "key_pair" {
    description = "Key pair for servers"
}

variable "ssh_password" {
    description = "SSH password"
}
