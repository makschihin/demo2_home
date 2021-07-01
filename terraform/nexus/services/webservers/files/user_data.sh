#!/bin/bash
  sudo apt update -y \
  && sudo apt-add-repository --yes --update ppa:ansible/ansible \
  && sudo apt update -y \
  && sudo apt-get install git software-properties-common ansible unzip -y \
  && sudo apt-get install openjdk-8-jdk -y \
  && sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y \
  && sudo useradd -M -d /opt/nexus -s /bin/bash -r nexus \
  && sudo su \
  && echo "nexus ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nexus \
  && mkdir /opt/nexus \
  && wget https://sonatype-download.global.ssl.fastly.net/repository/downloads-prod-group/3/nexus-3.29.2-02-unix.tar.gz \
  && tar xzf nexus-3.29.2-02-unix.tar.gz -C /opt/nexus --strip-components=1 \
  && chown -R nexus:nexus /opt/nexus 