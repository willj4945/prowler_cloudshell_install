#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color


# Ensure pip is installed
if ! command -v pip &> /dev/null
then
    echo -e "${RED}pip could not be found, installing...${NC}"
    sudo apt-get update && sudo apt-get install -y python3-pip
fi

# Clone the Prowler repository
git clone https://github.com/prowler-cloud/prowler.git

# Change to the Prowler directory
cd prowler

# Install poetry if not already installed
if ! command -v poetry &> /dev/null
then
    echo -e "${RED}Poetry could not be found, installing...${NC}"
    pip install --user poetry
fi

# Install poetry plugin:shell
if ! command -v poetry-plugin-shell &> /dev/null
then
    echo -d "${RED}Poetry-plugin-shell could not be found, installing...${NC}"
    pip install --user poetry-plugin-shell
fi

# Create the directory for poetry cache
mkdir -p /tmp/poetry

# Configure poetry to use the new cache directory
poetry config cache-dir /tmp/poetry

# Activate the poetry environment and install dependencies
poetry install

# Run Prowler with verbose output
poetry run python prowler.py -v

# Activate the venv

poetry shell

# Run the prowler scan
