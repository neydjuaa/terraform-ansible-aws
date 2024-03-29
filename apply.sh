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



#!/bin/bash

# Chemin complet du fichier de configuration
fichier="/home/muharrem/projetbt/ansible/ansible.cfg"

# Vérifie si le fichier existe
if ! test  -f "$fichier"; then
    # Si le fichier existe, ajoute ou écrase son contenu avec les configurations souhaitées
    echo "[defaults]" > "$fichier"
    echo "inventory = inventory" >> "$fichier"
    echo "host_key_checking = false" >> "$fichier"
else
    # Si le fichier n'existe pas, affiche un message
    echo "Le fichier $fichier n'existe pas."
fi


#ajout adresses ip à l'inventory

if ! test -f /home/muharrem/projetbt/ansible/inventory; then
  touch ansible/inventory
  haha=$(terraform output -json public_ip)
  echo "$haha" | jq -r 'to_entries[] | "echo \(.key) ansible_host=\(.value) >> ansible/inventory"' | bash
  echo "[all:vars]" >> ansible/inventory
  echo "ansible_ssh_private_key_file = ../keys/private_key.pem" >> ansible/inventory
  echo "ansible_user = ubuntu"  >> ansible/inventory
else
  echo "It's ok"
fi

