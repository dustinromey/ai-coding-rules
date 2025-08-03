#!/bin/bash

# Check if task completion commands were run and remind about protocol
if ls tasks/tasks-*.md 1> /dev/null 2>&1; then
    # Check if any tasks were marked complete recently
    recent_completions=$(grep "\[x\]" tasks/tasks-*.md 2>/dev/null | wc -l)
    
    if [ "$recent_completions" -gt 0 ]; then
        echo "✅ TASK COMPLETION DETECTED:"
        echo "   Follow completion protocol:"
        echo "   1. Update memory bank files"
        echo "   2. Ask user: 'Sub-task complete. Continue to next? (y/n)'"
        echo "   3. Wait for permission before proceeding"
        
        # Check if all sub-tasks for any parent are complete
        while IFS= read -r line; do
            if echo "$line" | grep -q "^- \[ \].*[0-9]\+\.0"; then
                parent_num=$(echo "$line" | grep -o "[0-9]\+\.0")
                sub_complete=$(grep "^\s*- \[x\].*${parent_num%.*}\.[1-9]" tasks/tasks-*.md 2>/dev/null | wc -l)
                sub_total=$(grep "^\s*- \[.\].*${parent_num%.*}\.[1-9]" tasks/tasks-*.md 2>/dev/null | wc -l)
                
                if [ "$sub_complete" -eq "$sub_total" ] && [ "$sub_total" -gt 0 ]; then
                    echo "🎯 PARENT TASK ${parent_num%.*} ready to mark complete (all sub-tasks done)"
                fi
            fi
        done < <(cat tasks/tasks-*.md 2>/dev/null)
    fi
fi

# Check if this was a git commit and remind about memory bank updates
if echo "$@" | grep -q "git.*commit"; then
    echo "📚 POST-COMMIT REMINDER:"
    echo "   Ensure memory bank reflects committed changes."
    echo "   Update progress.md with current project status."
fi