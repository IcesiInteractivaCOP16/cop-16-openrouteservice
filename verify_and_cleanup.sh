#!/bin/bash

# Function to install Docker
install_docker() {
  echo "Installing Docker..."
  sudo apt-get update
  sudo apt-get install -y docker.io
  sudo systemctl start docker
  sudo systemctl enable docker
}

# Function to install Docker Compose
install_docker_compose() {
  echo "Installing Docker Compose..."
  sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

# Check if Docker is installed
if ! [ -x "$(command -v docker)" ]; then
  echo "Docker is not installed. Attempting to install..."
  install_docker
else
  echo "Docker is installed."
fi

# Check if Docker Compose is installed
if ! [ -x "$(command -v docker-compose)" ]; then
  echo "Docker Compose is not installed. Attempting to install..."
  install_docker_compose
else
  echo "Docker Compose is installed."
fi

# Stop all running containers
if [ "$(docker ps -q)" ]; then
  echo "Stopping all running containers..."
  docker stop $(docker ps -q)
else
  echo "No running containers."
fi

# Remove all containers
if [ "$(docker ps -a -q)" ]; then
  echo "Removing all containers..."
  docker rm $(docker ps -a -q)
else
  echo "No containers to remove."
fi

# Remove all images
if [ "$(docker images -q)" ]; then
  echo "Removing all images..."
  docker rmi -f $(docker images -q)
else
  echo "No images to remove."
fi

# Remove all volumes
if [ "$(docker volume ls -q)" ]; then
  echo "Removing all volumes..."
  docker volume rm $(docker volume ls -q)
else
  echo "No volumes to remove."
fi

echo "Cleanup complete."
