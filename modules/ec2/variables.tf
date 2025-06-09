variable "vpc_id" {
  description = "VPC ID"
}

variable "public_subnet_id" {
  description = "Public subnet ID"
}

variable "private_subnet_id" {
  description = "Private subnet ID"
}

variable "sg_name" {
  description = "Name for security group"
}

variable "key_name" {
  description = "SSH key pair name"
}

variable "allowed_ssh_ips" {
  description = "List of objects with IP and rule name for SSH access"
}
