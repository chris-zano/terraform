#!/bin/bash

set -e

# Update and upgrade system packages
sudo apt update -y
sudo apt upgrade -y

# Install Docker
if ! command -v docker &> /dev/null; then
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  rm get-docker.sh
fi

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add current user to the docker group (for non-root access)
sudo usermod -aG docker "$USER"

# Run nginx container in detached mode, exposing port 80
sudo docker run -d -p 80:80 nginx
