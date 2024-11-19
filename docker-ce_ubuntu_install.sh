#!/bin/bash
### --- Install Docker CE on Ubuntu 24.04 ---

## Error Managment
set -euo pipefail

## System prep
sudo apt update
sudo apt install -y apt-transport-https curl gpg

## Add Docker GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

## Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt update

## Install Docker-CE, etc
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

## Verify installation
if docker --version >/dev/null 2>&1; then
    echo -e "\n\n  Docker successfully installed: $(docker --version) \n"
else
    echo -e "\n\n  Docker installation failed! \n" >&2
    exit 1
fi
