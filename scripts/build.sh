#!/bin/bash

# Ensure dependencies are installed
if ! command -v pandoc &> /dev/null; then
    echo "Pandoc is not installed. Please install it to convert Markdown to PDF."
    exit 1
fi

if ! command -v marked &> /dev/null; then
    echo "Marked is not installed. Installing via npm..."
    npm install -g marked@5.0.0
fi

# Convert Markdown to HTML and PDF
marked -o ../docs/whitepaper.html ../docs/whitepaper.md
pandoc ../docs/whitepaper.md -o ../docs/whitepaper.pdf

# Copy the generated files to the public directory if they exist
[ -f ../docs/whitepaper.html ] && cp ../docs/whitepaper.html ../public/whitepaper.html
[ -f ../docs/whitepaper.pdf ] && cp ../docs/whitepaper.pdf ../public/whitepaper.pdf || echo "Warning: PDF generation failed, skipping copy."

echo "Whitepaper built successfully: HTML and PDF versions generated in docs/ and copied to public/"