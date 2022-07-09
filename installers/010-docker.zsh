#!/usr/bin/env zsh

# https://docs.docker.com/engine/install/ubuntu/

sudo apt -yqq update
sudo apt -yqq install \
  ca-certificates \
  curl \
  gnupg \
  lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get -yqq update
sudo apt-get -yqq install docker-ce docker-ce-cli containerd.io docker-compose-plugin
