# provision.sh
 #!/bin/bash

# Update and upgrade
sudo apt-get update -y && sudo apt-get upgrade -y

# Install Python and pip
sudo apt-get install -y python3 python3-pip  python3-venv
pip3 install django

# Install Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce

# Add vagrant user to docker group
sudo usermod -aG docker vagrant

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Git
sudo apt-get install -y git

# Clean up
sudo apt-get autoremove -y
