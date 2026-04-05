#!/usr/bin/env bash
set -euo pipefail

cd ~/terraform-aws

echo "Applying Terraform configuration..."
# terraform apply -auto-approve > /dev/null 2>&1
terraform apply -auto-approve | grep -E "Apply complete"
terraform output > outputs.txt
echo ""

echo "Switching to Ansible..."
cd ansible

echo "Configuring Instances..."
echo "Standby..."
ansible-playbook plays/full-deployment.yml

echo ""
cat ~/terraform-aws/outputs.txt
echo ""
echo "Deployment complete!"

