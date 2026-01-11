---
name: build-verify
description: Verify code changes compile, pass tests, and satisfy linting/formatting requirements
---

## Purpose

Use this skill after making code changes to verify correctness. Adapt verification
to what's available in the project.

## When to Use

- After completing a logical unit of work (not every micro-change)
- Before declaring a task complete
- When the user asks to verify or check changes

## When NOT to Use

- After every small edit during a multi-step refactor
- When changes are incomplete and won't compile yet
- When the user explicitly says to skip verification

## Detection & Execution

### Makefile Projects (Check First)

Look for: `Makefile`, `makefile`, `GNUmakefile`

If a Makefile exists, prefer it over language-specific commands. Check available
targets by reading the Makefile or running `make help` if available.

Common targets to look for:
- `make test` or `make check` - Run tests
- `make lint` - Run linters
- `make fmt` or `make format` - Check/apply formatting
- `make build` - Compile
- `make verify` or `make all` - Run everything

### Go Projects

Look for: `go.mod`, `*.go` files

```bash
go build ./...           # Compilation check
go test ./...            # Unit tests  
go vet ./...             # Static analysis
```

If available (check if installed):
- `golangci-lint run` - Comprehensive linting
- `staticcheck ./...` - Additional static analysis

Formatting: `go fmt ./...` (or `gofmt -l .` to check without modifying)

### Python Projects

Look for: `pyproject.toml`, `setup.py`, `requirements.txt`, `*.py` files

Check `pyproject.toml` for tool configuration and available commands.

```bash
pytest                   # or python -m pytest
```

If available:
- `mypy .` or `python -m mypy .` - Type checking
- `ruff check .` - Fast linting
- `ruff format --check .` - Format checking
- `black --check .` - Format checking (if ruff not available)

If using `uv`:
- `uv run pytest`
- `uv run mypy .`
- `uv run ruff check .`

### TypeScript/JavaScript Projects

Look for: `package.json`, `tsconfig.json`, `*.ts`, `*.tsx`, `*.js` files

First, read `package.json` to see available scripts. Common patterns:

```bash
npm test                 # or pnpm test, bun test
npm run typecheck        # or npx tsc --noEmit
npm run lint             # or npx eslint .
npm run build            # Compilation/bundle check
```

Detect package manager by looking for lock files:
- `pnpm-lock.yaml` -> use `pnpm`
- `bun.lockb` -> use `bun`
- `package-lock.json` or `yarn.lock` -> use `npm` or `yarn`

## Execution Order

Run checks in this order (fastest/cheapest first):

1. **Compile/Build** - Catch syntax errors immediately
2. **Lint** - Catch style and potential bugs
3. **Type Check** - Catch type errors (if applicable)
4. **Tests** - Verify behavior

If any step fails, stop and report the failure. Don't continue to later steps.

## Reporting Results

- Clearly state what was checked
- Report successes briefly
- Report failures with enough context to fix them
- If a tool isn't available, note it and continue with available tools
