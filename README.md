# DGOV DTT Architecture Decision Records

Architecture records and current decision state to support infrastructure and platform operations for Office of Digital
Government (DGOV) Digital Transformation and Technology Unit (DTT).

## For WA Public Sector Agencies

This repository provides **reusable architecture patterns** for WA Government digital services. Whether you're building
a new system or modernising existing infrastructure, start here:

### Getting Started

1. **Review the [Architecture Principles](architecture-principles.md)** - Six guiding principles for all technology decisions
2. **Choose a Reference Architecture** - Project kickoff templates that combine multiple ADRs:
   - [Content Management](reference-architectures/content-management.md) - Websites and content portals
   - [Data Pipelines](reference-architectures/data-pipelines.md) - Analytics and ETL workloads
   - [Identity Management](reference-architectures/identity-management.md) - Federation and SSO
   - [OpenAPI Backends](reference-architectures/openapi-backends.md) - REST API services
3. **Deep dive into ADRs** - Individual decisions organised by domain:
   - `security/` - Isolation, secrets, identity, edge protection
   - `operations/` - Workloads, logging, backups, databases
   - `development/` - APIs, CI/CD, releases

### Compliance Alignment

These ADRs align with:
- [WA Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy)
- [ACSC Information Security Manual (ISM)](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)
- [WA Government AI Policy and Assurance Framework](https://www.wa.gov.au/government/publications/wa-government-artificial-intelligence-policy-and-assurance-framework)

Supporting training: [DGOV Technical - DevSecOps Induction](https://soc.cyber.wa.gov.au/training/devsecops-induction/)

---

## Repository Structure

This project uses [mdBook](https://rust-lang.github.io/mdBook/) to generate documentation from markdown files:

- **ADRs** are organised in directories by domain (`development/`, `operations/`, `security/`)
- **Reference Architectures** combine ADRs into project templates (`reference-architectures/`)
- **Navigation** is defined in `SUMMARY.md`
- **Build output** goes to `book/` directory

## Quick Start

```bash
just setup    # One-time setup
just serve    # Preview locally (port 8080)
```

Run `just` to see all available commands.

**[View as PDF](https://wagov-dtt.github.io/architecture-decision-records/architecture-decision-records.pdf)** | **[Browse online](https://wagov-dtt.github.io/architecture-decision-records/)**

## Contributing

New ADRs follow a structured format documenting the **context** (problem), **decision** (solution), and
**consequences** (risks).

1. Create new markdown file in appropriate directory (e.g., `security/019-new-topic.md`)
2. Add entry to `SUMMARY.md` in the correct section
3. Follow the ADR template structure

See the [Contributing Guide](CONTRIBUTING.md) for complete workflow and quality standards.

For AI agent assistance, see [AGENTS.md](AGENTS.md).
