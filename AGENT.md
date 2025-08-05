# Development Guide

## Essential Commands

| Command | Purpose |
|---------|---------|
| `./scripts/setup.sh` | Automated setup (first time) |  
| `just setup` | Install tools (rumdl, mdbook, linkcheck) |
| `just lint` | Lint, format check, SUMMARY.md check, and validate links |
| `just serve` | Preview website (port 8080) |
| `just build` | Generate website (includes link checking) |
| `just clean` | Remove generated files |
| `just next-number` | Get next ADR number |

## Quick Start

1. **Open in Codespaces** - Automatic setup with all tools
2. **Get ADR number** - `just next-number`
3. **Create file** - Use pattern `###-short-name.md` in correct directory
4. **Follow workflow** - See [CONTRIBUTING.md](CONTRIBUTING.md) for complete workflow, templates, and writing guidelines

## PDF Generation

- **Build** - `just build` creates both website and PDF at `book/pandoc/pdf/adr-guide.pdf`
- **Live PDF** - Available at [book/pandoc/pdf/adr-guide.pdf](book/pandoc/pdf/adr-guide.pdf)
- **Format** - A4 ISO standard with optimized fonts for ASCII diagrams

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
- **Diagram Support** - Use ASCII diagrams in code blocks for universal compatibility
