variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  description = "List of availability zones"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "key_name" {
  description = "SSH key pair name"
  default     = "task6key"
}

variable "allowed_ssh_ips" {
  description = "List of objects with IP and rule name for SSH access"
  default = [
    {
      ip      = "93.84.120.226/32"
      name    = "office-ip"
    }
  ]
}
