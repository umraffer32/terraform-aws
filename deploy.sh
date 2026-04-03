#!/usr/bin/env bash

set -euo pipefail

cd ~/terraform-aws

echo "Applying Terraform configuration..."
terraform apply -auto-approve

echo "Switching to Ansible..."
cd ansible

echo "Updating Bastion and NAT..."
ansible-playbook plays/update.yml -l role_bastion,role_nat

echo "Configuring NAT..."
ansible-playbook plays/nat.yml

echo "Updating Private Instances..."
ansible-playbook plays/update.yml -l role_private

echo "Deployment complete!"