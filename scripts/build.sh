#!/bin/bash

# Ensure dependencies are installed
if ! command -v pandoc &> /dev/null; then
    echo "Pandoc is not installed. Please install it to convert Markdown to PDF."
    exit 1
fi

if ! command -v marked &> /dev/null; then
    echo "Marked is not installed. Installing via npm..."
    npm install -g marked
fi

# Convert Markdown to HTML and PDF
marked -o ../docs/whitepaper.html ../docs/whitepaper.md
pandoc ../docs/whitepaper.md -o ../docs/whitepaper.pdf

# Copy or symlink the generated files to the public directory
cp ../docs/whitepaper.html ../public/whitepaper.html
cp ../docs/whitepaper.pdf ../public/whitepaper.pdf

echo "Whitepaper built successfully: HTML and PDF versions generated in docs/ and copied to public/"
