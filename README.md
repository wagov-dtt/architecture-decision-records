# DGOV DTT Architecture Decision Records

Architecture records and current decision state to support infrastructure and platform operations for Office of Digital
Government (DGOV) Digital Transformation and Technology Unit (DTT).  

Supporting training material is available at the [DGOV Technical - DevSecOps Induction](https://soc.cyber.wa.gov.au/training/devsecops-induction/)
(guided by the [WA Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy)).

The [Architecture Principles](architecture-principles.md) guide all decisions documented here.

## Structure

This project uses [mdBook](https://rust-lang.github.io/mdBook/) to generate documentation from markdown files:

- **ADRs** are organized in directories by domain (`development/`, `operations/`, `security/`)
- **Navigation** is defined in `SUMMARY.md`
- **Build output** goes to `book/` directory

## Quick Start

```bash
./scripts/setup.sh  # One-time setup
just serve          # Preview locally (port 8080)
```

Run `just` to see all available commands.

**[View as PDF](book/pandoc/pdf/adr-guide.pdf)** | **[Browse online](https://wagov-dtt.github.io/architecture-decision-records/)**

## Development

First time setup requires installing tools - use the setup script for automated installation.

## Contributing

New ADRs follow a structured format documenting the **context** (problem), **decision** (solution), and
**consequences** (risks).

1. Create new markdown file in appropriate directory (e.g., `security/019-new-topic.md`)
2. Add entry to `SUMMARY.md` in the correct section
3. Follow the ADR template structure

See the [Contributing Guide](CONTRIBUTING.md) for complete workflow and quality standards.
