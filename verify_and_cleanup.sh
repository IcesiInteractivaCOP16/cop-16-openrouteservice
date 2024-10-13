#!/bin/bash

# Check if Docker is installed
if ! [ -x "$(command -v docker)" ]; then
  echo "Error: Docker is not installed." >&2
  exit 1
else
  echo "Docker is installed."
fi

# Check if Docker Compose is installed
if ! [ -x "$(command -v docker-compose)" ]; then
  echo "Error: Docker Compose is not installed." >&2
  exit 1
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
