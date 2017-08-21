#!/bin/bash
sudo apt-get update
sudo apt-get install -y build-essential software-properties-common python-dev python-pip
sudo pip install boto --user
sudo pip install boto3 --user
sudo pip install awscli 
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible
ansible-playbook localdeploy.yml
