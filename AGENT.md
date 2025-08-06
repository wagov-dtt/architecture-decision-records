# Development Guide

## Essential Commands

| Command | Purpose |
|---------|---------|
| `just serve` | Preview documentation locally (port 8080) |
| `just next-number` | Get next ADR number for new files |
| `just lint` | Run all checks and fixes |
| `just build` | Build documentation website (includes link checking) |
| `just setup` | Install required tools and dependencies |
| `just clean` | Clean generated files |

## Quick Start

### Workflow
1. **Get ADR number** - `just next-number`
2. **Create file** - Use pattern `###-short-name.md` in correct directory
3. **Follow workflow** - See [CONTRIBUTING.md](CONTRIBUTING.md) for complete workflow, templates, and writing guidelines

## PDF Generation

- **Build** - `just build` creates both website and PDF at `book/pandoc/pdf/adr-guide.pdf`
- **Live PDF** - Available at [book/pandoc/pdf/adr-guide.pdf](book/pandoc/pdf/adr-guide.pdf)
- **Format** - A4 ISO standard with D2 diagrams

## Troubleshooting

**Setup Issues:**

- Restart devcontainer if Homebrew fails
- Run `eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"` if commands not found
- If PDF generation fails, ensure system dependencies are installed: `sudo apt-get install -y chromium`

**Validation Issues:**

- Run `just lint` to check all issues
- Use `just clean` then `just serve` if preview issues occur

## Automated Workflows

- **Website deployment** - Automatically builds and deploys to GitHub Pages on push to `main`
- **PDF generation** - Automatically creates and attaches PDFs to GitHub releases  
- **Chapter ordering** - Files sorted numerically by ADR number

## mdBook Project Notes

- **Book Format** - Project uses mdBook, navigation defined in `SUMMARY.md`
- **Manual Updates** - Add new ADR files to `SUMMARY.md` for navigation (required)
- **Diagram Support** - Use D2 diagrams in code blocks for universal compatibility

## D2 Diagram Guidelines

**When to use:** System relationships, data flows, workflows, or architecture patterns where text alone isn't sufficient.

**Keep simple:** Maximum 5-7 components, clear labels, logical flow, consistent colors.

**Example:**
```d2
user: User -> api: API -> backend: Backend
api: requests/responses
```

**Quality check:** Adds value, easy to follow, clear labels, logical connections.
