#!/bin/bash

# Check if AI should be in Plan mode before making changes
if [ -f ".claude/core.mdc" ] || [ -f "core.mdc" ]; then
    echo "⚠️  PLAN/ACT MODE CHECK:"
    echo "   Are you in ACT mode? Only make changes after user approval."
    echo "   If in PLAN mode, present your plan and wait for 'ACT' confirmation."
    echo "   Remember: Default mode is PLAN - you should start there."
fi

# Check for active tasks that might need completion first
if ls tasks/tasks-*.md 1> /dev/null 2>&1; then
    incomplete_tasks=$(grep -c "^\s*- \[ \]" tasks/tasks-*.md 2>/dev/null || echo "0")
    if [ "$incomplete_tasks" -gt 0 ]; then
        echo "📋 ACTIVE TASKS: $incomplete_tasks incomplete tasks found."
        echo "   Consider completing current tasks before starting new work."
    fi
fi