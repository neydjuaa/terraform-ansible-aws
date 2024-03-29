#!/bin/bash

# dossier où va être généré la clé privé ssh
mkdir ./keys
#dossier où les fichier de config. ansible seront placées
mkdir ./ansible

terraform init

if [ $? -eq 0 ] 
then
  echo 
  echo  "Initialization OK"
  echo
fi

terraform apply -auto-approve



touch ansible/ansible.cfg
touch ansible/inventory

echo "[defaults]" >> ansible/ansible.cfg
echo "inventory = inventory" >> ansible/ansible.cfg
echo "host_key_checking = false" >> ansible/ansible.cfg

#ajout adresse ip à l'inventory

haha=$(terraform output -json public_ip)
echo "$haha" | jq -r 'to_entries[] | "echo \(.key) ansible_host=\(.value) >> ansible/inventory"' | bash
