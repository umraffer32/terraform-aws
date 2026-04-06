admin_cidr = "YOUR PUBLIC IP/32"
key_name   = "YOUR EC2 KEY PAIR NAME"
private_1_count = 1                       # Default is 1. Set this number higher if you want more than 1 instance in the subnet
private_2_count = 1                       # DO NOT LEAVE BLANK!!!


#  Examples:
#  admin_cidr = "1.1.1.1/32"
#  key_name = "Alpha"


# Update the above variables with your own values
# Then copy this file to terraform.tfvars and run the deployment script deploy.sh


# ======= REQUIREMENTS BELOW =======:

# AWS account
# AWS CLI installed and configured
# An existing EC2 key pair (key_name above must match)


# NOTE:
# Ansible uses group_vars to control connections to nat and private instances
# For manual SSH troubleshooting, use the SSH config below
# Default username for Debian 13 AWS instances is admin


# Host bastion
#   User admin
#   HostName <bastion public IP>
#   IdentityFile <file path to EC2 key pair>
#   IdentitiesOnly yes
#   StrictHostKeyChecking accept-new

# Host nat
#   User admin
#   HostName <nat private IP>
#   IdentityFile <file path to EC2 key pair>
#   IdentitiesOnly yes
#   StrictHostKeyChecking accept-new
#   ProxyJump bastion



