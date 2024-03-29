#!/bin/bash

terraform destroy -auto-approve
rm -rf ansible/
rm -rf keys/

