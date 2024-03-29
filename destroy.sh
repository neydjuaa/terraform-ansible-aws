#!/bin/bash

terraform destroy -auto-approve
rm ansible/inventory
rm ansible/ansible.cfg

