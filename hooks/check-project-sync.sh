#!/bin/bash

# Check if AI coding rules are out of sync
if [ -f "sync-rules.sh" ] && [ -f "core.mdc" ]; then
    # Check if local rules are newer than global ones
    if [ -f "$HOME/.claude/core.mdc" ]; then
        if [ "core.mdc" -nt "$HOME/.claude/core.mdc" ]; then
            echo "🔄 RULES OUT OF SYNC:"
            echo "   Local rules are newer than global rules."
            echo "   Run ./sync-rules.sh to update global rules."
        fi
    else
        echo "🔧 GLOBAL RULES NOT FOUND:"
        echo "   Run ./sync-rules.sh to set up global AI coding rules."
    fi
fi

# Check if this project has been initialized with AI rules
if [ ! -d ".claude" ] && [ -f "init-project.sh" ]; then
    echo "🚀 PROJECT NOT INITIALIZED:"
    echo "   Run ./init-project.sh to set up AI coding rules for this project."
fi

# Warn about commands that might break the unified process
if echo "$1" | grep -qE "(git push|git merge|git rebase)"; then
    echo "⚠️  GIT OPERATION WARNING:"
    echo "   Ensure memory bank is updated before pushing changes."
    echo "   Consider if this affects active task execution."
fi