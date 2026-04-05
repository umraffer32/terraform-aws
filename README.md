# Terraform AWS VPC with Bastion, NAT, and Private Instances

End-to-end infrastructure automation using Terraform and Ansible to deploy a secure AWS VPC with a bastion host, NAT instance, and scalable private instances.

## What This Builds

- 1 VPC (10.0.0.0/16)
- 1 Public Subnet
  - Bastion Host (SSH entry point)
  - NAT Instance (outbound internet for private hosts)
- 2 Private Subnets
  - Scalable private EC2 instances (no public IPs)
- Security Groups configured for:
  - Bastion → NAT access
  - Bastion → Private access
  - Private → NAT outbound access

  ## Architecture Overview

- Bastion host is the only public entry point (SSH)
- NAT instance provides outbound internet access for private instances
- Private instances have **no public IPs**
- All management of NAT and private instances is done via the bastion (ProxyJump)

### Access Flow

Your Machine → Bastion (public IP) → NAT / Private (private IPs)

## Project Structure

```text
terraform-aws/
├── ansible/
│   ├── ansible.cfg
│   ├── aws_ec2.yml
│   ├── group_vars/
│   │   ├── role_nat/
│   │   │   └── main.yml
│   │   └── role_private/
│   │       └── main.yml
│   └── plays/
│       ├── full-deployment.yml
│       ├── nat.yml
│       ├── reboot.yml
│       └── update.yml
├── deploy.sh
├── network.tf
├── security.tf
├── compute.tf
├── outputs.tf
├── variables.tf
├── terraform.example.tfvars
└── README.md
```

## Prerequisites

- AWS account
- AWS CLI installed and configured (`aws configure`)
- Terraform installed
- Ansible installed
- Existing EC2 key pair in AWS
- SSH private key stored locally (e.g., `~/.ssh/YOURKEY.pem`)

## Configuration

Copy the example variables file:
```
cp terraform.example.tfvars terraform.tfvars
```
Then update the values in **terraform.tfvars**:

- admin_cidr = your public IP in CIDR format
- key_name = your existing AWS EC2 key pair name
- private_1_count = number of private instances in subnet 1
- private_2_count = number of private instances in subnet 2

