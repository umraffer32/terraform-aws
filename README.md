## Overview

This project provisions a complete AWS networking and compute environment using Terraform and configures instances using Ansible. The architecture includes a custom VPC with public and private subnets, a bastion host for secure access, and a NAT instance to provide outbound internet access for private instances. Terraform is used to build the infrastructure, while Ansible is used to configure and manage the instances after deployment.

## Architecture

The environment is deployed inside a custom VPC and is split across public and private subnets.

- **Public Subnet**
  - Bastion host (SSH access point)
  - NAT instance (provides outbound internet for private instances)

- **Private Subnets**
  - EC2 instances with no public IPs
  - Outbound internet access routed through NAT instance

- **Access Flow**
  - User → Bastion Host → Private Instances
  - Private Instances → NAT → Internet

<!-- ![Architecture Diagram](images/CIDR.png) -->

