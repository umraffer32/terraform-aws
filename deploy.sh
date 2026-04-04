#!/usr/bin/env bash
set -euo pipefail

cd ~/terraform-aws

echo "Applying Terraform configuration..."
terraform apply -auto-approve

echo "Switching to Ansible..."
cd ansible

echo "Configuring Instances..."
echo "Standby..."
ansible-playbook plays/full-deployment.yml

echo "Deployment complete!"
