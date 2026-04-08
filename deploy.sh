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

# This script will deploy the infrastructure using Terraform, and then run the Ansible playbook to configure the instances.
# It suppresses most of the "terraform apply" output, but still shows the final summary and the instance IP's at the end.
# The Terraform output is saved to outputs.txt which is generated when the deploy script runs, and is used to display the instance IP's cleanly at the end of Ansible's execution.
