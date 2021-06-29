#!/bin/bash
  sudo apt update -y \
  && sudo apt-add-repository --yes --update ppa:ansible/ansible \
  && sudo apt update -y \
  && sudo apt-get install git software-properties-common ansible -y \
  && git clone https://github.com/Chmokachka/Dp-206-DevOps-Home.git /opt/home \
  && ansible-playbook --connection=local  /opt/home/terraform-home/ansible/all_server.yml \
  && sudo echo "hello" >> /home/ubuntu/hello.txt
  