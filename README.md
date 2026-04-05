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

## Deployment

Run the deployment script:

```bash
./deploy.sh
```

This will:

1) Apply Terraform infrastructure
2) Configure instances with Ansible
3) Set up NAT routing and persistence
4) Reboot instances if required
5) Output infrastructure details at the end

## SSH Access

This project uses a bastion host as the single public SSH entry point.

- Your machine connects directly to the bastion using its public IP
- The NAT instance is managed through the bastion using its private IP
- Private instances are also managed through the bastion using their private IPs

### Access Path

Your Machine → Bastion (public) → NAT / Private Instances (private)

## Why the NAT Instance Still Has a Public IP

The NAT instance is administered using its **private IP** through the bastion host, but it still requires a **public IP** for outbound internet access.

This is because private instances do not have public IPs and rely on the NAT instance to reach the internet for package updates and other outbound traffic.

### Design Summary

- **Bastion** = public SSH entry point
- **NAT** = public for egress, private for management
- **Private instances** = private only

## Idempotence

This deployment is fully idempotent.

- The first run performs all provisioning and configuration
- Subsequent runs result in no changes if the infrastructure is already in the desired state
- Reboots only occur when the system explicitly requires it (`/var/run/reboot-required`)

This ensures consistent and predictable deployments across multiple runs.

## Key Features

- Bastion-based SSH access (no direct access to private instances)
- NAT instance providing outbound internet for private subnets
- Private instances with no public IPs
- Security group-based access control (no subnet-wide trust)
- Scalable private instances using Terraform `count`
- Idempotent Ansible configuration
- Conditional reboots based on system requirements
- Clean deployment output with summarized Terraform outputs

## Future Improvements

- Convert Ansible plays into reusable roles
- Add tagging support for partial deployments
- Implement rolling updates using `serial` for large-scale environments
- Replace NAT instance with AWS NAT Gateway
- Enhance logging and output formatting

## Cleanup

To destroy all resources:

```bash
terraform destroy --auto-approve
```

## Notes

This project was built as a hands-on exercise to design, deploy, and manage AWS infrastructure using Terraform and Ansible.

It focuses on secure access patterns, automation, and repeatable deployments.

