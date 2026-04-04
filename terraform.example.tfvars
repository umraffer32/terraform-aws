admin_cidr = "YOUR PUBLIC IP/32"
key_name   = "YOUR PRIVATE AWS KEY NAME"

##  Examples:
##  admin_cidr = "1.1.1.1/32"
##  key_name = "Alpha"


## Update the above variables with your own values
## Then copy this file to terraform.tfvars and run the deployment script deploy.sh


## Requirements:
## - AWS account
## - AWS CLI installed and configured
## - An existing EC2 key pair (key_name above must match)
