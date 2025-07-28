# Development Guide

## Essential Commands

| Command | Purpose |
|---------|---------|
| `just next-number` | Get next ADR number |
| `just validate` | Check format and prose quality |
| `just serve` | Preview website (port 8080) |
| `just build` | Generate website/PDF |
| `just clean` | Remove generated files |
| `just update-chapters` | Update book chapters from files |

## Quick Start

1. **Open in Codespaces** - Automatic setup with all tools
2. **Get ADR number** - `just next-number`
3. **Create file** - Use pattern `###-short-name.qmd` in correct directory
4. **Write ADR** - Follow template structure
5. **Validate** - `just validate` (fix any issues)
6. **Preview** - `just serve` to check locally
7. **Submit PR** - No need to update index files

## ADR Structure

```text
development/    # API standards, CI/CD, releases
operations/     # Infrastructure, logging, config
security/       # Isolation, secrets, AI governance
```

## Template

```markdown
---
title: "ADR ###: Decision Title"
date: YYYY-MM-DD
status: Proposed
tags: [#category, #tech]
---

## Context
Problem statement and background

## Decision
What we decided and implementation approach

## Consequences
Trade-offs, risks, and benefits
```

## Writing Guidelines

- **Avoid Extended Characters** - Use ASCII characters only to prevent PDF font rendering issues
  - Use `"quotes"` not `"smart quotes"`
  - Use `--` not em dashes `—`
  - Use `[x]` or `YES` instead of unicode symbols like `✅`
  - Use standard apostrophes `'` not curved `'`

## Automated Features

- **Chapter ordering** - Files sorted numerically by ADR number
- **Executive summaries** - Index pages automatically updated by build
- **Acronym checking** - Vale ensures first-use definitions
- **Prose quality** - Write-good catches wordy/passive constructions

## Troubleshooting

**Setup Issues:**

- Restart devcontainer if Homebrew fails
- Run `eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"` if commands not found

**Validation Issues:**

- Check frontmatter format matches template exactly
- Run `just validate` to check all issues
- Use `just clean` then `just build` if preview issues occur

## Automated Workflows

- **Website deployment** - Automatically builds and deploys to GitHub Pages on push to `main`
- **PDF generation** - Automatically creates and attaches PDFs to GitHub releases
- **Chapter ordering** - Files sorted numerically by ADR number
- **Index updates** - Executive summaries automatically generated
- **Auto-add directories** - `just update-chapters` automatically adds any top-level directory containing `.qmd` files to book structure

## Quarto Project Notes

- **Diagram Support** - Use Mermaid diagrams with ````{mermaid}` code blocks (full quarto support with captions)
- **Reference Architectures** - Located in root directory, use simple flat structure
- **Book Format** - Project uses quarto book format, chapters defined in `_quarto.yml`

## Maintainer Tasks

1. Review proposed ADRs (change status to Accepted)
2. Create releases through GitHub (PDFs automatically attached)
3. Monitor GitHub Actions for build status
