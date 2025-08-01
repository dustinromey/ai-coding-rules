<<<<<<< HEAD
# AI Coding Rules

A centralized set of coding rules and instructions for AI assistants (Claude Code, Gemini CLI, Cursor, Zed) that ensures consistent behavior across projects.

## Features

- **Unified Rules**: Single source of truth for all AI coding assistants
- **Multi-Tool Support**: Works with Claude Code, Gemini CLI, Cursor, and Zed
- **Easy Setup**: One-command initialization for new projects
- **Global + Local**: Support for both global user settings and per-project rules

## Quick Start

### For New Projects

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/ai-coding-rules.git
   cd ai-coding-rules
   ```

2. Initialize rules in your project:
   ```bash
   ./init-project.sh /path/to/your/project
   ```

### For Global Setup

Run the sync script to set up global rules:
```bash
./sync-rules.sh
```

This creates:
- `~/.claude/` - Claude Code global rules (symlinked)
- `~/.config/gemini/` - Gemini CLI rules (converted .md files)
- `~/.config/zed/` - Zed editor rules (converted markdown)

## File Structure

```
├── core.mdc                 # Core behavioral rules
├── memory-bank.mdc         # Memory management process
├── unified-dev-process.mdc # Development workflow
├── generate-tasks.mdc      # Task generation rules
├── init-project.sh         # Project initialization script
├── sync-rules.sh          # Global rules sync script
└── README.md              # This file
```

## Rules Overview

- **Plan/Act Mode**: AI operates in plan mode by default, requires approval before making changes
- **Memory Management**: Structured approach to maintaining context between sessions
- **Unified Development**: Consistent workflow across different AI tools
- **Task Generation**: Systematic approach to breaking down complex work

## Tool-Specific Notes

### Claude Code
- Uses `.mdc` files with frontmatter
- Supports global rules via `~/.claude/`
- Local project rules via `.claude/` directory

### Gemini CLI
- Requires `.md` files (frontmatter stripped)
- Looks for specific filenames like `memory-bank-process.md`
- Local project rules via `.gemini/` directory

### Cursor
- Uses `.mdc` files with frontmatter
- Local project rules via `.cursor/` directory

### Zed
- Uses converted markdown files
- Rules placed in `~/.config/zed/coding-rules.md`

## Usage

After setup, your AI assistants will automatically follow the defined rules. Key behaviors:

1. **Start in PLAN mode** - AI will plan before acting
2. **Follow memory bank process** - Maintain structured documentation
3. **Use unified development workflow** - Consistent approach across tools

## Customization

Edit the `.mdc` files to customize rules, then run:
- `./sync-rules.sh` - Update global rules
- `./init-project.sh` - Update project rules

## License

MIT License - feel free to adapt for your needs.
=======
# ai-coding-rules
>>>>>>> 7ddfbbb24dccfe3d3409d5d0a6043d3e55831edc
