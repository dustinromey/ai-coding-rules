# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Project Setup and Initialization
```bash
# Initialize AI coding rules in a new project
./init-project.sh [project-directory]

# Sync rules globally across all AI tools (Claude Code, Gemini CLI, Zed)
./sync-rules.sh
```

### Development Commands
- No traditional build/test commands - this is a rules configuration repository
- Shell scripts are executable and should be run directly
- Use `chmod +x *.sh` if scripts need execute permissions

### Hook Management
```bash
# Test hook configuration validity
# Hooks use new array format with matchers as of Claude Code updates
# Example: {"PreToolUse": [{"matcher": {"tools": ["*"]}, "hooks": [{"type": "command", "command": "script.sh"}]}]}
```

## Architecture Overview

This repository implements a centralized AI coding rules framework with two core architectural concepts:

### 1. Plan/Act Mode System
- **Plan Mode**: AI analyzes requests, gathers information, and proposes detailed plans without making changes
- **Act Mode**: AI executes approved plans and makes actual codebase changes
- Default mode is Plan Mode; requires explicit user approval (`ACT`) to switch
- AI returns to Plan Mode after each response unless instructed otherwise

### 2. Memory Bank System
- Structured markdown files serving as AI's long-term memory across sessions
- Core files: `projectbrief.md`, `productContext.md`, `activeContext.md`, `systemPatterns.md`, `techContext.md`, `progress.md`
- AI must read ALL memory bank files at session start
- Maintained through unified development process with automatic updates

### File Structure and Responsibilities

```
├── core.mdc                 # Plan/Act mode rules and core behavioral guidelines
├── memory-bank.mdc          # Memory bank structure and maintenance process
├── unified-dev-process.mdc  # Complete development workflow (PRD → tasks → execution)
├── generate-tasks.mdc       # Task generation specifics from PRDs
├── init-project.sh          # Project initialization (creates .claude/, .gemini/, .cursor/ dirs)
└── sync-rules.sh            # Global sync (symlinks for Claude, converts for other tools)
```

### Multi-Tool Support Architecture
- **Master Rules**: All rules are authored in `.mdc` format with frontmatter
- **Tool-Specific Conversion**: Scripts automatically convert/sync to each tool's format:
  - Claude Code: Symlinks to `.mdc` files in `~/.claude/` and `.claude/`
  - Gemini CLI: Stripped `.md` files in `~/.config/gemini/` and `.gemini/`
  - Cursor: Copies `.mdc` files to `.cursor/`
  - Zed: Converted to `~/.config/zed/coding-rules.md`

### Development Workflow Integration
The repository defines a unified process that integrates:
1. **Memory Bank Foundation**: Session initialization with complete context reading
2. **PRD to Task Generation**: Two-phase breakdown (high-level → detailed sub-tasks)
3. **Task Execution Protocol**: One sub-task at a time with user permission
4. **Documentation Maintenance**: Automatic memory bank updates after each task
5. **Project Intelligence**: Learning journal in `.gemini/rules` for pattern capture

### Key Implementation Patterns
- **Frontmatter Configuration**: `.mdc` files use YAML frontmatter for rule metadata
- **Tool-Agnostic Design**: Rules written once, automatically adapted per tool
- **Session State Management**: Memory bank maintains context across AI session resets
- **Progressive Task Execution**: Prevents AI from rushing ahead without user approval
- **Documentation-First**: All changes require corresponding memory bank updates

## Important Notes
- This repository contains configuration and rules, not executable code
- The Supabase project_id 'zpvwoxgaiorjvduuwmzm' is referenced in core rules
- All AI responses should be terse and direct per core behavioral guidelines
- Scripts handle frontmatter stripping automatically for tools that don't support it
- Hook scripts are located in `hooks/` directory and must be executable
- The `hooks-settings.json` uses the new Claude Code hooks format with matcher arrays

## Troubleshooting

### Hook Configuration Issues
If you encounter "Expected array, but received object" errors:
1. Ensure `hooks-settings.json` uses the new format with `matcher` objects
2. Run `./init-project.sh` to update existing projects with corrected hooks
3. Verify hook scripts in `hooks/` directory are executable (`chmod +x hooks/*.sh`)