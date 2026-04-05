output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}

# output "nat_public_ip" {
#   description = "Public IP of the NAT instance"
#   value       = aws_instance.nat.public_ip
# }

output "nat_private_ip" {
  description = "Private IP of the NAT instance"
  value       = aws_instance.nat.private_ip
}

output "private_subnet_1_ips" {
  description = "Private IPs of instances in subnet 1"
  value       = aws_instance.private_1[*].private_ip
}

output "private_subnet_2_ips" {
  description = "Private IPs of instances in subnet 2"
  value       = aws_instance.private_2[*].private_ip
}

# output "bastion_ssh_command" {
#   description = "SSH command for bastion"
#   value       = "ssh ${aws_instance.bastion.public_ip}"
# }
