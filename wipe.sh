#!/bin/bash

echo "Cleaning SSH known_hosts..."
echo

IPS=$(terraform output -json | jq -r '.. | .value? // empty | if type=="array" then .[] else . end')

for ip in $IPS; do
    echo "Removing $ip from known_hosts"
    ssh-keygen -R "$ip" >/dev/null 2>&1
done

echo
echo "Destroying infrastructure..."
terraform destroy --auto-approve | grep -E "Destroy complete"

