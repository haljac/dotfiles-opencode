---
name: git-commit
description: Guidelines for creating git commits when explicitly requested by the user
---

## Purpose

Provide guidance on commit workflow. ONLY use when the user explicitly asks
to commit changes.

## Critical Rules

- NEVER commit without explicit user permission
- NEVER push without explicit user permission
- NEVER force push
- NEVER amend commits that have been pushed
- Always show the user what will be committed before committing

## Prerequisites

Before committing:

1. User has explicitly requested a commit
2. Changes have been verified (use `build-verify` skill if not already done)
3. You understand what files should be included

## Process

### 1. Review Current State

```bash
git status                    # See what's changed
git diff                      # See unstaged changes
git diff --cached             # See staged changes
```

### 2. Determine What to Commit

- Ask the user if it's unclear which files to include
- Don't include unrelated changes in the same commit
- Don't include generated files unless necessary
- Be cautious with sensitive files (.env, credentials, etc.)

### 3. Stage Files

```bash
git add <specific-files>      # Prefer specific files over git add .
```

### 4. Draft Commit Message

Use conventional commit format when appropriate:

```
<type>: <short summary>

[optional body with more detail]
```

Types:
- `feat:` - New feature
- `fix:` - Bug fix
- `refactor:` - Code change that neither fixes a bug nor adds a feature
- `docs:` - Documentation only
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks, dependency updates
- `style:` - Formatting, whitespace (no code change)
- `perf:` - Performance improvement

Guidelines:
- Subject line: imperative mood, ~50 chars, no period
- Body: wrap at 72 chars, explain what and why (not how)

### 5. Show User and Confirm

Before executing, show:
- Files to be committed (`git diff --cached --stat`)
- Proposed commit message
- Ask for confirmation

### 6. Commit

```bash
git commit -m "type: message"
```

Or for multi-line messages:
```bash
git commit -m "type: subject" -m "Body text here"
```

## What NOT to Do

- Don't use `git add .` without reviewing what it includes
- Don't commit with generic messages like "fix bug" or "update code"
- Don't combine unrelated changes in one commit
- Don't commit broken code (verify first)
- Don't push unless explicitly asked
- Don't use `--no-verify` to skip hooks
