#!/bin/bash

# Sync rules across Claude Code, Gemini CLI, and Zed
echo "Syncing coding rules across tools..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RULES_DIR="$SCRIPT_DIR"
CLAUDE_DIR="$HOME/.claude"
GEMINI_DIR="$HOME/.config/gemini"
ZED_DIR="$HOME/.config/zed"

# Ensure directories exist
mkdir -p "$CLAUDE_DIR" "$GEMINI_DIR" "$ZED_DIR"

# Remove existing symlinks/files
rm -f "$CLAUDE_DIR"/*.mdc "$GEMINI_DIR"/*.mdc "$GEMINI_DIR"/*.md

# Create symlinks for Claude Code 
ln -sf "$RULES_DIR"/*.mdc "$CLAUDE_DIR/"

# Create .md versions for Gemini CLI (strip frontmatter)
for file in "$RULES_DIR"/*.mdc; do
    basename=$(basename "$file" .mdc)
    sed '1,/^---$/d' "$file" > "$GEMINI_DIR/$basename.md"
done

# Create specific named files that Gemini expects
if [ -f "$RULES_DIR/memory-bank.mdc" ]; then
    sed '1,/^---$/d' "$RULES_DIR/memory-bank.mdc" > "$GEMINI_DIR/memory-bank-process.md"
fi

# Convert core.mdc to markdown for Zed (manual sync required for complex rules)
if [ -f "$RULES_DIR/core.mdc" ]; then
    # Extract content after the frontmatter
    sed '1,/^---$/d' "$RULES_DIR/core.mdc" > "$ZED_DIR/coding-rules.md"
    echo "" >> "$ZED_DIR/coding-rules.md"
    echo "NOTE: This file is auto-generated from $RULES_DIR/core.mdc" >> "$ZED_DIR/coding-rules.md"
    echo "Run $RULES_DIR/sync-rules.sh to update after changing master rules." >> "$ZED_DIR/coding-rules.md"
fi

echo "✅ Rules synced successfully!"
echo "📁 Master rules: $RULES_DIR"
echo "🔗 Claude Code: $CLAUDE_DIR (symlinked)"
echo "📄 Gemini CLI: $GEMINI_DIR (converted .md files)"  
echo "📄 Zed: $ZED_DIR/coding-rules.md (converted)"