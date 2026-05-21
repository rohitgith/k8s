#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update -y

# Install Java (Default JDK)
echo "Installing Default JDK..."
sudo apt install default-jdk -y

# Install OpenJDK 21 Runtime and fontconfig
echo "Installing OpenJDK 21 JRE..."
sudo apt install fontconfig openjdk-21-jre -y

# Verify Java installation
echo "Checking Java version..."
java -version

# Create keyrings directory if not exists
echo "Creating keyrings directory..."
sudo mkdir -p /etc/apt/keyrings

# Add Jenkins repository key
echo "Adding Jenkins repository key..."
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian/jenkins.io-2026.key

# Add Jenkins repository
echo "Adding Jenkins repository..."
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list again
echo "Updating package list after adding Jenkins repo..."
sudo apt update -y

# Install Jenkins
echo "Installing Jenkins..."
sudo apt install jenkins -y

# Enable Jenkins service
echo "Enabling Jenkins service..."
sudo systemctl enable jenkins

# Start Jenkins service
echo "Starting Jenkins service..."
sudo systemctl start jenkins

# Install Git
echo "Installing Git..."
sudo apt install git -y

# Restart Jenkins
echo "Restarting Jenkins..."
sudo systemctl restart jenkins

# Show Jenkins status
echo "Checking Jenkins status..."
sudo systemctl status jenkins --no-pager

# Display Jenkins initial admin password
echo "Jenkins Initial Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "======================================"
echo "Jenkins installation completed."
echo "Access Jenkins on:"
echo "http://<YOUR_SERVER_IP>:8080"
echo "======================================"