# Global OpenCode Rules

## Identity

You are assisting a developer who works primarily in Go, Python, and TypeScript.

## Git & GitHub

- I use the `gh` CLI for GitHub operations
- NEVER commit or push without explicit permission
- NEVER create branches without explicit permission
- NEVER create PRs or issues without explicit permission
- Read-only git/gh operations are fine (status, diff, log, branch list, etc.)

## Build Verification

When making code changes, use the `build-verify` skill to understand how to
verify changes are correct. Be smart about when to verify:

- DO verify before considering a task complete
- DO verify after completing a logical unit of work
- DON'T verify after every micro-change during a multi-step refactor
- DON'T verify if multiple changes are needed before code will compile

## Project Structure Convention

Projects following my convention will have:

- `AGENTS.md` in the root with project-specific context
- `docs/` directory with detailed documentation:
  - `domain.md` - Business domain, terminology, key concepts
  - `architecture.md` - Tech stack, patterns, project structure
  - `product.md` - Features, roadmap, user context
  - `strategy.md` - Priorities, decisions, coding standards

These files are automatically loaded via the instructions config.

## Code Style Preferences

- Prefer explicit over implicit
- Write tests for new functionality
- Run formatters and linters before considering work complete
- Follow existing patterns in the codebase

## Language-Specific Notes

### Go
- Use `golangci-lint` when available
- Prefer table-driven tests
- Handle errors explicitly

### Python
- Use `ruff` for linting and formatting when available
- Use type hints
- Use `pytest` for testing

### TypeScript
- Prefer strict TypeScript configuration
- Use ESLint and Prettier when available
