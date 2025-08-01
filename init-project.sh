#!/bin/bash

# Initialize coding rules for a new project
# Usage: ./init-project.sh [project-directory]

PROJECT_DIR="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
    sed '1,/^---$/d' "$file" > "$PROJECT_DIR/.gemini/$basename.md"
done
# Create the specific file Gemini expects
sed '1,/^---$/d' "$SCRIPT_DIR/memory-bank.mdc" > "$PROJECT_DIR/.gemini/memory-bank-process.md"

echo "📋 Setting up Cursor rules..."
cp "$SCRIPT_DIR"/*.mdc "$PROJECT_DIR/.cursor/"

# Create gitignore entries if .gitignore exists
if [ -f "$PROJECT_DIR/.gitignore" ]; then
    echo "" >> "$PROJECT_DIR/.gitignore"
    echo "# AI Tool Rules (optional - you may want to commit these)" >> "$PROJECT_DIR/.gitignore"
    echo "# .claude/" >> "$PROJECT_DIR/.gitignore"
    echo "# .gemini/" >> "$PROJECT_DIR/.gitignore"
    echo "# .cursor/" >> "$PROJECT_DIR/.gitignore"
fi

echo "✅ Project rules initialized!"
echo "📁 Rules copied to:"
echo "   - $PROJECT_DIR/.claude/ (Claude Code)"
echo "   - $PROJECT_DIR/.gemini/ (Gemini CLI)"  
echo "   - $PROJECT_DIR/.cursor/ (Cursor)"
echo ""
echo "💡 Tip: You can commit these to share rules with your team,"
echo "   or add them to .gitignore to keep them personal."