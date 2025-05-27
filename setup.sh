#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting OpenRecon setup...${NC}"

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Python3 is not installed. Please install Python 3.8 or higher"
    exit 1
fi

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo "pip3 is not installed. Please install pip3"
    exit 1
fi

# Check if virtualenv is installed, if not install it
if ! command -v virtualenv &> /dev/null; then
    echo -e "${BLUE}Installing virtualenv...${NC}"
    pip3 install virtualenv
fi

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo -e "${BLUE}Creating virtual environment...${NC}"
    python3 -m virtualenv venv
fi

# Activate virtual environment
echo -e "${BLUE}Activating virtual environment...${NC}"
source venv/bin/activate

# Install requirements
echo -e "${BLUE}Installing requirements...${NC}"
pip install -r requirements.txt

# Install the package in development mode
echo -e "${BLUE}Installing OpenRecon in development mode...${NC}"
pip install -e .

# Install and setup Playwright
echo -e "${BLUE}Installing Playwright...${NC}"
pip install playwright
echo -e "${BLUE}Installing Playwright browsers...${NC}"
playwright install

# Check if nmap is installed
if ! command -v nmap &> /dev/null; then
    echo -e "${BLUE}Please note: Nmap is required for some features.${NC}"
    echo "On Ubuntu/Debian: sudo apt-get install nmap"
    echo "On CentOS/RHEL: sudo yum install nmap"
    echo "On Fedora: sudo dnf install nmap"
fi

# Check for system dependencies that Playwright needs
echo -e "${BLUE}Checking Playwright system dependencies...${NC}"
if command -v apt-get &> /dev/null; then
    echo "For Ubuntu/Debian systems, you might need to install the following dependencies:"
    echo "sudo apt-get install libnss3 libnspr4 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 libxfixes3 libxrandr2 libgbm1 libpango-1.0-0 libcairo2 libasound2"
elif command -v yum &> /dev/null; then
    echo "For CentOS/RHEL systems, you might need to install the following dependencies:"
    echo "sudo yum install nss nspr atk at-spi2-atk cups-libs libdrm libXcomposite libXdamage libXfixes libXrandr libxkbcommon pango cairo alsa-lib"
fi

echo -e "${GREEN}Setup completed successfully!${NC}"
echo -e "${BLUE}To activate the virtual environment, run: source venv/bin/activate${NC}" 