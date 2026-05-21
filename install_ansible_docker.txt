
#!/bin/bash

# ============================================
# Ansible + Docker Installation Script
# Ubuntu Version: Noble (24.04)
# ============================================

set -e

echo "======================================"
echo "Updating system packages..."
echo "======================================"

sudo apt update -y

# Install required packages
echo "Installing required dependencies..."
sudo apt install -y gnupg curl lsb-release ca-certificates software-properties-common

# ============================================
# Install Ansible
# ============================================

echo "======================================"
echo "Installing Ansible..."
echo "======================================"

UBUNTU_CODENAME=noble

# Add Ansible GPG Key
curl -fsSL "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | \
sudo gpg --dearmor -o /usr/share/keyrings/ansible-archive-keyring.gpg

# Add Ansible Repository
echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] \
http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | \
sudo tee /etc/apt/sources.list.d/ansible.list

# Update and Install Ansible
sudo apt update -y
sudo apt install -y ansible

# Verify Ansible Installation
echo "Checking Ansible version..."
ansible --version

# ============================================
# Install Docker
# ============================================

echo "======================================"
echo "Installing Docker..."
echo "======================================"

# Create Docker keyrings directory
sudo install -m 0755 -d /etc/apt/keyrings

# Add Docker GPG Key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
-o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker Repository
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

# Update package list
sudo apt update -y

# Install Docker Packages
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start and Enable Docker
sudo systemctl enable docker
sudo systemctl start docker

# Check Docker Status
sudo systemctl status docker --no-pager

# Test Docker Installation
echo "Running Docker test container..."
sudo docker run hello-world

echo "======================================"
echo "Installation Completed Successfully!"
echo "======================================"

echo "Installed Components:"
echo "- Ansible"
echo "- Docker Engine"
echo "- Docker Compose Plugin"
echo "- Docker Buildx"
echo "======================================"