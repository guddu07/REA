#!/bin/bash
sudo apt-get update
# Install basic software development tools
sudo apt-get install -y build-essential software-properties-common python-dev python-pip

# Install Python libraries required for AWS EC2 dynamic inventory to run
sudo pip install boto --user
sudo pip install boto3 --user
sudo pip install awscli 

# Add Ansible repository and install the same
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

# Run Ansible playbook to configure local workstation ready
ansible-playbook localdeploy.yml
