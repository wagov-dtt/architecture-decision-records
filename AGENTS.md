# AI Agent Guide

This repository is designed for use by AI coding agents (primarily [Goose](https://github.com/block/goose))
to assist with architecture decisions and implementation.

## Philosophy

This guide aligns with pragmatic engineering principles:

- **[The Grug Brained Developer](https://grugbrain.dev/)**: Prefer simplicity over complexity. "Complexity very bad."
  Choose boring technology, avoid over-engineering, and make systems easy to understand and debug.
- **[CNCF](https://www.cncf.io/) / [Linux Foundation](https://www.linuxfoundation.org/)**: Preference for open-source,
  cloud-native technologies with strong community governance. Avoid vendor lock-in where practical.

## Getting Started

1. **Review the [Architecture Principles](architecture-principles.md)** - Foundation for all decisions
2. **Browse [Reference Architectures](reference-architectures/)** - Project kickoff templates combining multiple ADRs
3. **Search ADRs by domain** - `security/`, `operations/`, `development/`

## Essential Commands

```bash
mise tasks
    build  Build the book (just build with tool prereqs for CI)
just --list
    default       # Show all available commands

    [build]
    build         # Build documentation website (includes link checking)
    clean         # Clean generated files

    [development]
    next-number   # Get next ADR number for new files
    serve         # Preview documentation locally (port 8080)

    [quality]
    check-summary # Verify SUMMARY.md includes all markdown files
    lint          # Run all checks and fixes

    [setup]
    setup         # Install required tools and dependencies
```

## Workflow

1. **Get ADR number** - `just next-number`
2. **Create file** - Use pattern `###-short-name.md` in correct directory
3. **Follow workflow** - See [CONTRIBUTING.md](CONTRIBUTING.md) for complete workflow, templates, and writing guidelines

## PDF Generation

- **Build** - `just build` creates both website and PDF at `book/pandoc/pdf/architecture-decision-records.pdf`
- **Live PDF** - Available at [architecture-decision-records.pdf](https://wagov-dtt.github.io/architecture-decision-records/architecture-decision-records.pdf)
- **Format** - A4 ISO standard with D2 diagrams

## Troubleshooting

**Validation Issues:**

- Run `just lint` to check all issues

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

**Keep simple:** Maximum 5-7 components, clear labels, logical flow.

**Syntax rules:**

- Use `direction: down` for compact/square layouts, `direction: right` for flows
- No color styling (remove `style.fill`, `style.stroke` etc.)
- No `.note` suffix on nodes
- No `\n` in labels (use shorter text or separate nodes)
- Use containers with `{}` for grouping related items

**Example:**

```d2
direction: down

workloads: Workloads
storage: Primary Storage
backup: Backup Storage

workloads -> storage: data
storage -> backup: replication
```

**Quality check:** Adds value, easy to follow, clear labels, logical connections.

## Writing Style

- **Australian English**: Use `organisation`, `centralised`, `standardised`, `minimise`, `authorisation`, `behaviour`
- **Plain text safe**: Avoid smart quotes (`'` `"` `'` `"`), use straight quotes (`'` `"`)
- **Expand acronyms**: Define on first use (e.g., "Recovery Time Objective (RTO)")
- **Active voice**: "Configure logging" not "Logging should be configured"
- **Cross-references**: Link related ADRs, add references to reference-architectures where helpful

## Common Fixes

When reviewing ADRs, check for:

1. **Unicode issues**: Replace curly quotes with straight quotes
2. **US spelling**: Fix to Australian English (but preserve external URLs)
3. **Diagram complexity**: Simplify to 5-7 nodes, use `direction: down` for compactness
4. **Missing links**: Add cross-references between related ADRs
5. **Vague guidance**: Add specific values (e.g., rotation periods, timeframes)
6. **Broken links**: Run `just lint` to catch 404s
