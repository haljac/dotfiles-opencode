---
name: project-bootstrap
description: How to set up a new project to work well with this OpenCode configuration
---

## Purpose

Guide for bootstrapping a new project with OpenCode conventions. Use this when
setting up a new project or adding OpenCode support to an existing one.

## Overview

Projects following this convention will have:

```
project/
├── AGENTS.md              # Project context and references
├── docs/
│   ├── domain.md          # Business domain knowledge
│   ├── architecture.md    # Technical architecture
│   ├── product.md         # Product context
│   └── strategy.md        # Development strategy
└── opencode.json          # (optional) project-specific config
```

## Step 1: Create AGENTS.md

Create an `AGENTS.md` file in the project root. This is the entry point for
project context.

### Template

```markdown
# Project Name

Brief description of what this project does and why it exists.

## Quick Reference

- Language: [Go 1.22 / Python 3.12 / TypeScript 5.x / etc.]
- Build: `make build` or `go build ./...` or `npm run build`
- Test: `make test` or `go test ./...` or `npm test`
- Lint: `make lint` or `golangci-lint run` or `npm run lint`

## Documentation

See `docs/` for detailed context:
- `docs/domain.md` - Business domain and terminology
- `docs/architecture.md` - Technical architecture and patterns
- `docs/product.md` - Product features and roadmap
- `docs/strategy.md` - Development priorities and decisions

## Key Conventions

[List 3-5 important patterns or rules specific to this project]

- Example: "All API endpoints return JSON with {data, error} structure"
- Example: "Use repository pattern for database access"
- Example: "Feature flags are defined in config/features.go"
```

## Step 2: Create docs/ Directory

Create the `docs/` directory with these files. Not all projects need all files;
create what's relevant.

### docs/domain.md

Business domain knowledge that helps understand the problem space.

```markdown
# Domain

## Overview

[What business problem does this solve? Who are the users?]

## Key Concepts

### [Concept 1]
[Definition and explanation]

### [Concept 2]
[Definition and explanation]

## Terminology

| Term | Definition |
|------|------------|
| ... | ... |

## Business Rules

- [Rule 1]
- [Rule 2]

## Domain Entities

[Describe the main entities and their relationships]
```

### docs/architecture.md

Technical architecture and patterns.

```markdown
# Architecture

## Tech Stack

- Language: 
- Framework:
- Database:
- Key dependencies:

## Project Structure

```
project/
├── cmd/           # Entry points
├── internal/      # Private packages
├── pkg/           # Public packages
└── ...
```

[Explain what each directory contains]

## Key Patterns

### [Pattern 1: e.g., Error Handling]
[How errors are handled in this project]

### [Pattern 2: e.g., Configuration]
[How configuration works]

### [Pattern 3: e.g., Database Access]
[How database access is structured]

## External Dependencies

[Key external services, APIs, or integrations]

## Data Flow

[How data flows through the system]
```

### docs/product.md

Product context and features.

```markdown
# Product

## Vision

[What is this product trying to achieve?]

## Current Features

- [Feature 1]
- [Feature 2]

## Roadmap

### In Progress
- [ ] ...

### Planned
- [ ] ...

## User Personas

### [Persona 1]
[Description of this user type and their needs]
```

### docs/strategy.md

Development strategy and decisions.

```markdown
# Strategy

## Current Priorities

1. [Priority 1]
2. [Priority 2]
3. [Priority 3]

## Coding Standards

[Project-specific standards beyond the global rules]

## Decision Log

### [Date]: [Decision Title]
- **Context**: [Why was this decision needed?]
- **Decision**: [What was decided]
- **Consequences**: [What are the implications]

## Known Technical Debt

- [ ] [Debt item 1]
- [ ] [Debt item 2]

## Testing Strategy

[How should this project be tested? What coverage is expected?]
```

## Step 3: Project-Specific Config (Optional)

If the project needs different settings from the global config, create
`opencode.json` in the project root. It merges with global config.

Example use cases:
- Allow additional bash commands specific to this project
- Add project-specific MCP servers
- Change permission settings for this project

```json
{
  "$schema": "https://opencode.ai/config.json",
  "permission": {
    "bash": {
      "docker-compose *": "allow",
      "./scripts/*.sh": "allow"
    }
  }
}
```

## Tips

- Start minimal and add documentation as the project grows
- Keep AGENTS.md as an index; put details in docs/
- Update docs when making significant changes
- The docs serve as both AI context and human documentation
