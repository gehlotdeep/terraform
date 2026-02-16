#!/bin/bash

# Update packages
apt-get update -y

# Install Java (required for Jenkins)
apt-get install -y openjdk-11-jdk curl gnupg

# Add Jenkins repository key (modern method)
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key \
  | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" \
  > /etc/apt/sources.list.d/jenkins.list

# Update again
apt-get update -y

# Install Jenkins
apt-get install -y jenkins

# Start and enable Jenkins
systemctl start jenkins
systemctl enable jenkins

# Install Nginx
apt-get install -y nginx

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx

# Update default webpage
echo "Hello World" | tee /var/www/html/index.html

