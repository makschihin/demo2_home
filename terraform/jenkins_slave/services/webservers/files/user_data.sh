#!/bin/bash
  sudo apt update -y \
  && sudo apt-add-repository --yes --update ppa:ansible/ansible \
  && sudo apt update -y \
  && sudo apt-get install git software-properties-common ansible unzip -y \
  && sudo apt-get install openjdk-8-jdk -y \
  && sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y \
  && git clone https://github.com/makschihin/demo2_home.git /opt/demo2_home \
  && ansible-playbook --connection=local  /opt/demo2_home/ansible/all_server.yml \
  && sudo echo "hello" >> /home/ubuntu/hello.txt