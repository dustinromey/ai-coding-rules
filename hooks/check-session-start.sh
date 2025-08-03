#!/bin/bash

# Check if memory bank exists and remind AI to read it
if [ -d "memory-bank" ]; then
    memory_files=(
        "memory-bank/projectbrief.md"
        "memory-bank/productContext.md" 
        "memory-bank/activeContext.md"
        "memory-bank/systemPatterns.md"
        "memory-bank/techContext.md"
        "memory-bank/progress.md"
    )
    
    missing_files=()
    for file in "${memory_files[@]}"; do
        if [ ! -f "$file" ]; then
            missing_files+=("$file")
        fi
    done
    
    if [ ${#missing_files[@]} -gt 0 ]; then
        echo "⚠️  MEMORY BANK INCOMPLETE: Missing files:"
        printf '   - %s\n' "${missing_files[@]}"
        echo "   Create missing files or run memory bank initialization."
    else
        echo "📚 REMINDER: Read ALL memory bank files to understand project context."
    fi
elif [ -f "tasks/tasks-*.md" ] 2>/dev/null; then
    echo "📋 TASK FILES FOUND: Review existing task list before proceeding."
fi

# Check if this is an AI coding rules project
if [ -f "core.mdc" ] && [ -f "memory-bank.mdc" ]; then
    echo "🤖 AI CODING RULES PROJECT: Apply Plan/Act mode and unified development process."
fi