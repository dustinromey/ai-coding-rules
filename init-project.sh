#!/bin/bash

# Initialize coding rules for a new project
# Usage: ./init-project.sh [project-directory]

PROJECT_DIR="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to strip frontmatter from mdc files
strip_frontmatter() {
    sed '1,/^---$/d' "$1"
}

echo "🚀 Initializing coding rules for project in: $PROJECT_DIR"

# Create local tool config directories
mkdir -p "$PROJECT_DIR/.claude"
mkdir -p "$PROJECT_DIR/.gemini"
mkdir -p "$PROJECT_DIR/.cursor"

# Copy rules to each tool's local directory
echo "📋 Setting up Claude Code rules..."
cp "$SCRIPT_DIR"/*.mdc "$PROJECT_DIR/.claude/"

echo "📋 Setting up Gemini CLI rules..."
for file in "$SCRIPT_DIR"/*.mdc; do
    basename=$(basename "$file" .mdc)
    strip_frontmatter "$file" > "$PROJECT_DIR/.gemini/$basename.md"
done
# Create the specific file Gemini expects
strip_frontmatter "$SCRIPT_DIR/memory-bank.mdc" > "$PROJECT_DIR/.gemini/memory-bank-process.md"

echo "📋 Setting up Cursor rules..."
cp "$SCRIPT_DIR"/*.mdc "$PROJECT_DIR/.cursor/"

# Create gitignore entries if .gitignore exists
if [ -f "$PROJECT_DIR/.gitignore" ]; then
    read -p "Do you want to add AI tool rules to .gitignore? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "" >> "$PROJECT_DIR/.gitignore"
        echo "# AI Tool Rules" >> "$PROJECT_DIR/.gitignore"
        echo ".claude/" >> "$PROJECT_DIR/.gitignore"
        echo ".gemini/" >> "$PROJECT_DIR/.gitignore"
        echo ".cursor/" >> "$PROJECT_DIR/.gitignore"
        echo "✅ Added AI tool rules to .gitignore"
    fi
fi

echo "✅ Project rules initialized!"
echo "📁 Rules copied to:"
echo "   - $PROJECT_DIR/.claude/ (Claude Code)"
echo "   - $PROJECT_DIR/.gemini/ (Gemini CLI)"
echo "   - $PROJECT_DIR/.cursor/ (Cursor)"
echo ""
echo "💡 Tip: You can commit these to share rules with your team,"
echo "   or add them to .gitignore to keep them personal."