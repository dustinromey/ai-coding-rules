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
- **Easy Setup**: A single command to initialize the rules in a new project.
- **Global & Local**: Supports both global user settings and per-project rules.

## File Structure

The project is organized as follows:

```
├── core.mdc                 # Core behavioral rules (Plan/Act mode)
├── memory-bank.mdc          # The memory management process
├── unified-dev-process.mdc  # The development workflow
├── generate-tasks.mdc       # Task generation rules
├── init-project.sh          # Project initialization script
├── sync-rules.sh            # Global rules sync script
└── README.md                # This file
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

### For Global Setup

To set up the rules globally for all your projects, run the sync script:

```bash
./sync-rules.sh
```

This will create symlinks and copies of the rules in the appropriate directories for each tool.

## Tool-Specific Notes

-   **Claude Code**: Uses `.mdc` files with frontmatter. Supports global rules in `~/.claude/` and local rules in `.claude/`.
-   **Gemini CLI**: Requires `.md` files (frontmatter is stripped). Looks for specific filenames like `memory-bank-process.md`. Local rules are in `.gemini/`.
-   **Cursor**: Uses `.mdc` files with frontmatter. Local rules are in `.cursor/`.
-   **Zed**: Uses converted markdown files. Rules are placed in `~/.config/zed/coding-rules.md`.

## Customization

To customize the rules, edit the `.mdc` files and then run the appropriate script:

-   `./sync-rules.sh` to update the global rules.
-   `./init-project.sh` to update the rules in a specific project.

## License

MIT License