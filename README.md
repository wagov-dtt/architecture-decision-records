# WA Government Architecture Decision Records

Reusable architecture patterns for WA Government digital services, maintained by the Office of Digital Government (DGOV) Digital Transformation and Technology Unit (DTT).

## For WA Public Sector Agencies

These patterns help you build secure, compliant digital services faster. Instead of starting from scratch, use proven approaches that align with WA Government security and compliance requirements.

### Getting Started

1. **Review the [Architecture Principles](architecture-principles.md)** - Six guiding principles for all technology decisions
2. **Choose a Reference Architecture** - Project kickoff templates combining multiple decisions:
   - [Content Management](reference-architectures/content-management.md) - Websites, intranets, and content portals
   - [Data Pipelines](reference-architectures/data-pipelines.md) - Analytics, reporting, and data processing
   - [Identity Management](reference-architectures/identity-management.md) - User authentication and single sign-on
   - [OpenAPI Backends](reference-architectures/openapi-backends.md) - Backend services and integrations
3. **Explore individual ADRs** - Detailed decisions organised by domain:
   - [Security](security/) - Isolation, secrets, identity, edge protection
   - [Operations](operations/) - Workloads, logging, backups, databases
   - [Development](development/) - APIs, CI/CD, releases

### Compliance Alignment

These ADRs align with:

- [WA Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy)
- [ACSC Information Security Manual (ISM)](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)
- [WA Government AI Policy and Assurance Framework](https://www.wa.gov.au/government/publications/wa-government-artificial-intelligence-policy-and-assurance-framework)

Supporting training: [DGOV Technical - DevSecOps Induction](https://soc.cyber.wa.gov.au/training/devsecops-induction/)

**[Browse online](https://wagov-dtt.github.io/architecture-decision-records/)** | **[Download PDF](https://wagov-dtt.github.io/architecture-decision-records/architecture-decision-records.pdf)**

---

## Contributing

New ADRs document the **context** (problem), **decision** (solution), and **consequences** (trade-offs). See the [Contributing Guide](CONTRIBUTING.md) for workflow and templates.

For AI agent assistance, see [AGENTS.md](AGENTS.md).

## Repository Structure

This project uses [mdBook](https://rust-lang.github.io/mdBook/) to generate documentation:

- `development/`, `operations/`, `security/` - ADRs by domain
- `reference-architectures/` - Project kickoff templates
- `SUMMARY.md` - Navigation structure

```bash
just setup    # One-time tool installation
just serve    # Preview locally (port 8080)
just build    # Build website and PDF
```
