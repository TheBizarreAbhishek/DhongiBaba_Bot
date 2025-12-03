#!/bin/bash

# Universal Downloader Bot Deployment Script

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting deployment...${NC}"

# Check for Docker
if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}Docker not found. Installing Docker...${NC}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    rm get-docker.sh
    echo -e "${GREEN}Docker installed successfully.${NC}"
else
    echo -e "${GREEN}Docker is already installed.${NC}"
fi

# Check for Git
if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}Git not found. Installing Git...${NC}"
    sudo apt-get update
    sudo apt-get install -y git
fi

# Clone Repository if not exists
if [ ! -d "DhongiBaba_Bot" ]; then
    echo -e "${GREEN}Cloning Dhongi Baba Bot repository...${NC}"
    git clone https://github.com/TheBizarreAbhishek/DhongiBaba_Bot.git
    cd DhongiBaba_Bot
else
    cd DhongiBaba_Bot
    echo -e "${GREEN}Pulling latest changes...${NC}"
    git pull
fi

# Check for Docker Compose
if ! docker compose version &> /dev/null; then
     echo -e "${YELLOW}Docker Compose plugin not found. Installing...${NC}"
     sudo apt-get update
     sudo apt-get install -y docker-compose-plugin
fi

# Check if config.py exists
if [ ! -f "CONFIG/config.py" ]; then
    echo -e "${YELLOW}CONFIG/config.py not found! Creating from template...${NC}"
    cp CONFIG/_config.py CONFIG/config.py
    echo -e "${YELLOW}PLEASE EDIT CONFIG/config.py WITH YOUR CREDENTIALS BEFORE RE-RUNNING THIS SCRIPT!${NC}"
    exit 1
fi

# Build and Start Containers
echo -e "${GREEN}Building and starting containers...${NC}"
docker compose up -d --build

echo -e "${GREEN}Deployment complete!${NC}"
echo -e "Check logs with: ${YELLOW}docker compose logs -f${NC}"
