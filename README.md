# OpenCode Configuration

Personal OpenCode configuration, designed to be symlinked to `~/.config/opencode`.

## Setup

```bash
./bootstrap.sh
```

This creates a symlink from `~/.config/opencode` to this repository. The script
will prompt before replacing any existing configuration.

## What's Included

### Permissions (`opencode.json`)

The configuration is designed to require approval for potentially destructive
actions while allowing read-only and verification commands to run freely.

| Action | Permission |
|--------|------------|
| File edits (write, edit, patch) | Ask |
| git status/diff/log/branch | Allow |
| git commit/push/checkout | Ask |
| gh read operations (pr view, issue list, etc.) | Allow |
| gh mutations (pr create, issue create, etc.) | Ask |
| Build/test/lint commands | Allow |
| Make targets | Allow |
| Other bash commands | Ask |

### Skills

Skills are on-demand instructions that OpenCode loads when relevant.

- **build-verify** - How to verify code changes (compile, lint, test) for
  Go, Python, TypeScript, and Makefile-based projects
- **git-commit** - Guidelines for creating commits (only when explicitly asked)
- **project-bootstrap** - How to set up a new project with OpenCode conventions

### Commands

- `/verify` - Run build verification for the current project

### Global Rules (`AGENTS.md`)

- Never commit or push without explicit permission
- Use `build-verify` skill to verify changes before completing tasks
- Language-specific guidance for Go, Python, and TypeScript

## Project Convention

For best results, structure your projects with:

```
your-project/
├── AGENTS.md           # Project overview, key conventions
├── docs/
│   ├── domain.md       # Business domain, terminology
│   ├── architecture.md # Tech stack, patterns, structure
│   ├── product.md      # Features, roadmap
│   └── strategy.md     # Priorities, decisions
└── opencode.json       # (optional) project-specific overrides
```

The global config automatically loads `docs/*.md` and `AGENTS.md` from any
project, so these files become part of the AI's context.

See the `project-bootstrap` skill for detailed templates and guidance:
```
Load the project-bootstrap skill
```

## Languages Supported

The permission config includes tooling for:

### Go
- `go test`, `go build`, `go vet`, `go fmt`, `go mod tidy`
- `golangci-lint`, `staticcheck`

### Python
- `pytest`, `mypy`, `ruff`, `black`
- `uv` commands
- `pip list`, `pip show`

### TypeScript/JavaScript
- `npm`, `pnpm`, `bun` test/lint/build commands
- `tsc`, `eslint`, `prettier`

## Customization

Edit files in this repo. Changes take effect immediately since
`~/.config/opencode` is a symlink.

### Adding More Allowed Commands

Edit `opencode.json` and add patterns to the `permission.bash` object:

```json
{
  "permission": {
    "bash": {
      "my-custom-command*": "allow"
    }
  }
}
```

### Adding Skills

Create a new directory under `skill/` with a `SKILL.md` file:

```
skill/
└── my-skill/
    └── SKILL.md
```

The SKILL.md must have frontmatter with `name` and `description`.

### Adding Commands

Create a markdown file in `command/`:

```
command/
└── my-command.md
```

The filename becomes the command name (`/my-command`).

### Adding MCP Servers (Per-Project)

MCP servers add to context, so they're best configured per-project rather than
globally. Add to your project's `opencode.json`:

```json
{
  "mcp": {
    "my-server": {
      "type": "local",
      "command": ["npx", "my-mcp-server"],
      "enabled": true
    }
  }
}
```

#### Recommended: Playwright for Web Projects

For projects with a web UI, add the Playwright MCP server to enable browser
automation, screenshots, and UI verification:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "playwright": {
      "type": "local",
      "command": ["npx", "@playwright/mcp@latest"],
      "enabled": true
    }
  }
}
```

This enables OpenCode to navigate pages, interact with elements, take
screenshots, fill forms, and verify UI changes. See
[@playwright/mcp](https://github.com/microsoft/playwright-mcp) for details.

## File Structure

```
.
├── README.md              # This file
├── bootstrap.sh           # Setup script
├── opencode.json          # Global config and permissions
├── AGENTS.md              # Global rules for the AI
├── skill/
│   ├── build-verify/      # Verification workflow
│   ├── git-commit/        # Commit guidelines
│   └── project-bootstrap/ # Project setup guide
└── command/
    └── verify.md          # /verify command
```
