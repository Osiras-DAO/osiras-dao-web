#!/bin/bash

# Exit on any error
set -e

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Install system dependencies
log "Installing system dependencies..."
apt-get update
apt-get install -y --no-install-recommends \
    pandoc \
    texlive-latex-base \
    texlive-fonts-recommended \
    texlive-extra-utils \
    texlive-latex-extra \
    texlive-xetex \
    lmodern

# Install Node.js dependencies
log "Installing Node.js dependencies..."
npm install -g marked

# Clean up
log "Cleaning up..."
apt-get clean
rm -rf /var/lib/apt/lists/*

log "Dependencies installed successfully!" 