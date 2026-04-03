variable "admin_cidr" {
  description = "Public IP in CIDR format allowed to SSH to the bastion"
  type        = string
}

variable "key_name" {
  type = string
}

