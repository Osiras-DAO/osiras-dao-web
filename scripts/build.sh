#!/bin/bash

# Exit on any error
set -e

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to ensure dependencies are installed
ensure_dependencies() {
    log "Checking dependencies..."
    
    # Check for marked
    if ! command_exists marked; then
        log "marked not found. Installing..."
        if [ "$EUID" -eq 0 ]; then
            npm install -g marked
        else
            sudo npm install -g marked
        fi
    fi

    # Check for pandoc
    if ! command_exists pandoc; then
        log "Error: pandoc is not installed"
        exit 1
    fi
}

# Function to create necessary directories
ensure_directories() {
    log "Ensuring directories exist..."
    mkdir -p public docs
}

# Function to build the whitepaper
build_whitepaper() {
    local source_file="docs/whitepaper.md"
    local html_output="public/whitepaper.html"
    local pdf_output="public/whitepaper.pdf"

    # Check if source file exists
    if [ ! -f "$source_file" ]; then
        log "Error: $source_file not found"
        exit 1
    }

    log "Building HTML version..."
    marked -i "$source_file" -o "$html_output"

    log "Building PDF version..."
    pandoc "$source_file" \
        -o "$pdf_output" \
        --pdf-engine=xelatex \
        --variable mainfont="DejaVu Sans" \
        --variable monofont="DejaVu Sans Mono" \
        --variable fontsize=11pt \
        --variable geometry="margin=1.2in" \
        --variable links-as-notes=true \
        --toc
}

# Main execution
main() {
    log "Starting build process..."
    
    # Ensure we're in the project root directory
    cd "$(dirname "$0")/.."
    
    ensure_dependencies
    ensure_directories
    build_whitepaper
    
    log "Build completed successfully!"
}

# Run main function
main