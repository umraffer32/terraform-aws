## Overview

This project provisions a complete AWS networking and compute environment using Terraform and configures instances using Ansible. The architecture includes a custom VPC with public and private subnets, a bastion host for secure access, and a NAT instance to provide outbound internet access for private instances. Terraform is used to build the infrastructure, while Ansible is used to configure and manage the instances after deployment.

## Architecture

The environment is deployed inside a custom VPC and is split across public and private subnets. This project uses the same architecture as a previous [ansible project](https://github.com/umraffer32/ansible/blob/main/README.md). The difference comes from the automatic deployment of the AWS infrastructure as opposed to using an existing one.

- **Public Subnet**
  - Bastion host (SSH access point)
  - NAT instance (provides outbound internet for private instances)

- **Private Subnets**
  - EC2 instances with no public IPs
  - Outbound internet access routed through NAT instance

- **Access Flow**
  - User → Bastion Host → Private Instances
  - Private Instances → NAT → Internet

![Architecture Diagram](images/architecture.png)

## What This Project Does

- Provisions a custom VPC with public and private subnets using Terraform
- Deploys a bastion host for secure SSH access
- Deploys a NAT instance to allow private instances outbound internet access
- Launches multiple EC2 instances in private subnets
- Uses Ansible to configure instances after deployment
- Implements SSH ProxyCommand for secure access to private instances
- Uses dynamic inventory to automatically discover AWS resources

## Technologies Used

- AWS (VPC, EC2, Security Groups, Networking, Subnets, Route Tables, Associations)
- Terraform (Infrastructure as Code)
- Ansible (Configuration Management)
- SSH (ProxyCommand / Bastion Access)
- Linux (Ubuntu 24.04 / Debian 13)

<!-- ## Project Structure -->

## How It Works

1. Terraform provisions the AWS infrastructure, including the VPC, subnets, security groups, and EC2 instances.
2. Once infrastructure is created, the deploy script executes Ansible.
3. Ansible uses the AWS dynamic inventory plugin to discover instances based on tags.
4. The bastion host is used as a jump host (ProxyCommand) to access private instances securely.
5. The NAT instance is configured to allow outbound internet access for private instances.
6. Ansible applies configuration tasks such as system updates and package installation.
7. The environment is fully automated and can be destroyed and recreated on demand.

## Deployment

### Prerequisites

- AWS account
- AWS CLI configured
- Terraform installed
- Ansible installed

### Steps

```bash
# Clone the repository
git clone https://github.com/umraffer32/terraform-aws.git
cd terraform-aws
```

```bash
# Deploy infrastructure and configure instances
./deploy.sh
```

```bash
# Destroy infrastructure when finished
terraform destroy --auto-approve
```

## Key Concepts Demonstrated

- Infrastructure as Code (Terraform)
- Configuration Management (Ansible)
- AWS VPC Networking (Public vs Private Subnets)
- Bastion Host Architecture
- NAT Instance for Private Subnet Internet Access
- SSH ProxyCommand for Secure Access
- Dynamic Inventory with AWS EC2 Plugin
- Idempotent Configuration Management

## Problems & Fixes

- **Private instances had no internet access**  
  Fixed by configuring the NAT instance for IP forwarding and MASQUERADE.

- **Private subnet routing failed**  
  Fixed by updating route tables to send outbound traffic through the NAT instance.

- **SSH access to private instances failed**  
  Fixed by using the bastion host as a jump host with ProxyCommand.

- **Dynamic bastion public IP caused connection issues**  
  Fixed by referencing the bastion host dynamically through Ansible inventory and host variables.

- **Ansible user mismatch caused SSH permission denied errors**  
  Fixed by explicitly setting the correct remote user for bastion and private hosts.

- **Group variable loading was inconsistent**  
  Fixed by aligning `group_vars` naming with Ansible inventory group names.

  ## Future Improvements

- Replace NAT instance with NAT Gateway for managed high availability
- Implement Application Load Balancer (ALB)
- Add Auto Scaling Group for dynamic instance scaling
- Introduce RDS for a highly available database layer
- Expand to a multi-AZ architecture using Terraform VPC module
- Add monitoring and alerting with CloudWatch
- Implement HTTPS using ACM and a custom domain