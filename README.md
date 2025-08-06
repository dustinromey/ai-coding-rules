# AI Coding Rules

A centralized set of coding rules and instructions for AI assistants that ensures consistent, high-quality behavior across projects.

This project provides a framework for guiding AI assistants like Claude Code, Gemini CLI, and others to follow a structured, predictable, and safe development process.

## Core Concepts

The rules are built on two fundamental concepts:

1.  **Plan/Act Mode**: To prevent unintended changes, the AI operates in two distinct modes. It starts in **Plan Mode**, where it analyzes the request, gathers information, and proposes a detailed plan. It will not make any changes to the codebase in this mode. Only after the user approves the plan does the AI switch to **Act Mode** to execute the plan.

2.  **The Memory Bank**: AI assistants are often stateless, meaning they have no memory of past interactions. The Memory Bank is a structured set of markdown files that serves as the AI's long-term memory. It contains the project brief, technical context, and progress logs. The AI is required to read the Memory Bank at the beginning of each session, ensuring it has the context it needs to work effectively.

## Features

- **Unified Rules**: A single source of truth for all AI coding assistants.
- **Multi-Tool Support**: Works with Claude Code, Gemini CLI, Cursor, and Zed.
- **Automated Enforcement**: Claude Code hooks automatically validate and remind about rule compliance.
- **Easy Setup**: A single command to initialize the rules in a new project.
- **Global & Local**: Supports both global user settings and per-project rules.

## File Structure

The project is organized as follows:

```
├── core.mdc                 # Core behavioral rules (Plan/Act mode)
├── memory-bank.mdc          # The memory management process
├── unified-dev-process.mdc  # The development workflow
├── generate-tasks.mdc       # Task generation rules
├── hooks-settings.json      # Claude Code hooks configuration
├── hooks/                   # Hook scripts for automated enforcement
│   ├── check-session-start.sh
│   ├── check-plan-mode.sh
│   ├── remind-memory-update.sh
│   ├── check-task-completion.sh
│   └── check-project-sync.sh
├── init-project.sh          # Project initialization script
├── sync-rules.sh            # Global rules sync script
└── README.md                # This file
```

**After running `./init-project.sh`, the project structure becomes:**
```
project/
├── .claude/
│   ├── settings.json        # Hooks configuration
│   ├── hooks/              # Hook scripts (executable)
│   └── *.mdc               # Rule files
├── .gemini/
│   └── GEMINI.md           # Unified context file
├── .cursor/
│   └── *.mdc               # Rule files
└── [your project files...]
```

## Quick Start

### For New Projects

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/ai-coding-rules.git
    cd ai-coding-rules
    ```

2.  **Initialize the rules in your project:**
    ```bash
    ./init-project.sh /path/to/your/project
    ```
    
    This sets up rules for all AI tools and configures Claude Code hooks for automatic enforcement.

### For Global Setup

To set up the rules globally for all your projects, run the sync script:

```bash
./sync-rules.sh
```

This will create symlinks and copies of the rules in the appropriate directories for each tool.

## Tool-Specific Notes

-   **Claude Code**: Uses `.mdc` files with frontmatter. Supports global rules in `~/.claude/` and local rules in `.claude/`. Includes automated hooks for rule enforcement.
-   **Gemini CLI**: Uses a unified `GEMINI.md` context file (frontmatter is stripped from source `.mdc` files). Local rules are in `.gemini/`.
-   **Cursor**: Uses `.mdc` files with frontmatter. Local rules are in `.cursor/`.
-   **Zed**: Uses converted markdown files. Rules are placed in `~/.config/zed/coding-rules.md`.

## Claude Code Hooks

The system includes automated hooks that enforce rule compliance in Claude Code:

### Hook Features
- **Memory Bank Validation**: Automatically checks for complete memory bank files and reminds AI to read them
- **Plan/Act Mode Enforcement**: Validates that AI is in correct mode before making changes  
- **Task Completion Tracking**: Monitors task progress and enforces completion protocol
- **Project Sync Validation**: Ensures rules are up-to-date and properly synchronized

### Hook Events
- **PreToolUse**: Validates state before tool execution
  - Session start checks for memory bank completeness
  - Plan/Act mode validation before Write/Edit operations
  - Project sync status verification before Bash commands

- **PostToolUse**: Provides reminders after tool execution
  - Memory bank update reminders after file changes
  - Task completion protocol enforcement
  - Progress tracking for completed sub-tasks

### Setup
Hooks are automatically configured when running `./init-project.sh`. The setup includes:
- `hooks-settings.json` copied to `.claude/settings.json`
- Hook scripts copied to `.claude/hooks/` directory
- All scripts made executable automatically

## Customization

To customize the rules, edit the `.mdc` files and then run the appropriate script:

-   `./sync-rules.sh` to update the global rules.
-   `./init-project.sh` to update the rules in a specific project.

### Customizing Hooks

To modify hook behavior:
1. Edit the shell scripts in the `.claude/hooks/` directory
2. Modify `hooks-settings.json` to change which tools trigger hooks
3. Re-run `./init-project.sh` to apply changes to projects

Hook scripts are written in bash and can be customized for project-specific requirements.

## License

MIT License