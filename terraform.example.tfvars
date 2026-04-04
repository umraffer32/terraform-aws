admin_cidr = "YOUR PUBLIC IP/32"
key_name   = "YOUR EC2 KEY PAIR NAME"

#  Examples:
#  admin_cidr = "1.1.1.1/32"
#  key_name = "Alpha"


# Update the above variables with your own values
# Then copy this file to terraform.tfvars and run the deployment script deploy.sh


# ======= REQUIREMENTS BELOW =======:

# AWS account
# AWS CLI installed and configured
# An existing EC2 key pair (key_name above must match)


# Create an SSH config file with the following:

# Host *                                            (Targets all hosts)
#   User ubuntu                                     (The default user is "ubuntu" for these VMs)
#   IdentitiesOnly yes                              (Only use the identity file specified below)
#   StrictHostKeyChecking accept-new                (So you don't have to type 'yes' when making a new SSH connection)
#   IdentityFile ~/.ssh/YOURKEY.pem                 (Update the file path if you have it elsewhere)

# Host bastion                                      (Command becomes: ssh bastion)
#   HostName <PUBLIC IP FOR BASTION>                (Example: HostName 1.1.1.1)

# Host nat                                          (Command becomes: ssh nat)
#   HostName <PRIVATE IP FOR NAT>                   (Example: HostName 10.0.2.50)
#   ProxyJump bastion                               (Specifies bastion as the jump host)


# NOTE:
# Having the bastion and nat entries in your SSH config is mainly for manual SSH convenience
# Ansible uses group_vars to control connections to nat and private instances
# The "Host *" section provides default SSH behavior such as user, key, and host key checking


