variable "admin_cidr" {
  description = "Public IP in CIDR format allowed to SSH to the bastion"
  type        = string
}

variable "key_name" {
  type = string
}

variable "private_1_count" {
  type    = number
  default = 1
}

variable "private_2_count" {
  type    = number
  default = 1
}
