#!/bin/bash

# Remind AI to update memory bank after making changes
if [ -d "memory-bank" ]; then
    echo "📝 MEMORY BANK UPDATE REQUIRED:"
    echo "   After making changes, update:"
    echo "   - memory-bank/activeContext.md (current focus, recent changes)"
    echo "   - memory-bank/progress.md (what works, current status)"
    
    # Check if significant changes were made to key files
    if [ -f "memory-bank/systemPatterns.md" ]; then
        echo "   - memory-bank/systemPatterns.md (if new patterns discovered)"
    fi
    
    # Check for .gemini/rules file
    if [ -f ".gemini/rules" ]; then
        echo "   - .gemini/rules (capture new project intelligence)"
    fi
fi

# If this is a task-based project, remind about task completion
if ls tasks/tasks-*.md 1> /dev/null 2>&1; then
    echo "✅ TASK COMPLETION:"
    echo "   Mark completed sub-tasks as [x] in task list file."
    echo "   Check if parent tasks should be marked complete."
fi