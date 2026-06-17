# WA Government Architecture Decision Records

**Status:** Accepted | **Date:** 2026-06-09 | **Review:** 2027-06-09

Reusable architecture patterns for WA Government digital services, maintained by the Office of Digital Government (DGOV) Digital Transformation and Technology Unit (DTT).

## For WA Public Sector Agencies

These patterns help you build secure, compliant digital services faster. Instead of starting from scratch, use proven approaches that align with WA Government security and compliance requirements.

### Getting Started

1. **Review the [ADR Design Guardrails](adr-design-guardrails.md)** - Six guiding principles for all technology decisions
2. **Use the [Decision Finder](decision-finder.md)** - Match a project need to the right ADRs and reference architectures
3. **Choose a Reference Architecture** - Project kickoff templates combining multiple decisions:
   - [AI-Assisted Digital Services](reference-architectures/ai-assisted-digital-services.md) - Low-risk AI assistance for services, staff workflows, CMS, and portals
   - [Content Management](reference-architectures/content-management.md) - Websites, intranets, and content portals
   - [Data Pipelines](reference-architectures/data-pipelines.md) - Analytics, reporting, and data processing
   - [Federated Application Portal](reference-architectures/federated-application-portal.md) - Standalone apps using shared account, identity, notification, and SDK services
   - [Identity Management](reference-architectures/identity-management.md) - User authentication and single sign-on
   - [OpenAPI Backends](reference-architectures/openapi-backends.md) - Backend services and integrations
4. **Check the [Compliance Mapping](compliance-mapping.md)** - Find which ADRs apply to your security and compliance requirements

### Find Guidance by Need

| If you need to... | Start with |
|-------------------|------------|
| Add AI assistance to a digital service or staff workflow | [AI-Assisted Digital Services](reference-architectures/ai-assisted-digital-services.md) |
| Launch a public website, intranet, or portal | [Content Management](reference-architectures/content-management.md) |
| Federate multiple standalone apps with shared account, identity, notification, or SDK services | [Federated Application Portal](reference-architectures/federated-application-portal.md) |
| Build reports, analytics, or data processing | [Data Pipelines](reference-architectures/data-pipelines.md) |
| Add login, single sign-on, or Digital ID | [Identity Management](reference-architectures/identity-management.md) |
| Build backend services or integrations | [OpenAPI Backends](reference-architectures/openapi-backends.md) |
| Check controls, standards, and policy coverage | [Compliance Mapping](compliance-mapping.md) |
| Review proposed guidance before adoption | [Proposed Decision Backlog](proposed-decision-backlog.md) |
| Review whether guidance is current | [Annual Review Schedule](review-schedule.md) |

### Compliance Alignment

These ADRs align with:

- [WA Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy)
- [ACSC Information Security Manual (ISM)](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)
- [WA Government AI Policy and Assurance Framework](https://www.wa.gov.au/government/publications/wa-government-artificial-intelligence-policy-and-assurance-framework)

Supporting training: [DGOV Technical - DevSecOps Induction](https://soc.cyber.wa.gov.au/training/devsecops-induction/)

**[Browse online](https://wagov-dtt.github.io/architecture-decision-records/)** | **[Printable long view](https://wagov-dtt.github.io/architecture-decision-records/print.html)**

---

## Contributing

New ADRs document the **context** (problem), **decision** (solution), and **consequences** (trade-offs). See the [Contributing Guide](CONTRIBUTING.md) for workflow and templates.

For AI-assisted contributions, see the guidance in [CONTRIBUTING.md](CONTRIBUTING.md).

All maintained guidance includes a review date. Set review dates one year after the document date unless a shorter review cycle is needed.

## Repository Structure

This project uses [mdBook](https://rust-lang.github.io/mdBook/) to generate documentation:

- `development/`, `operations/`, `security/` - ADRs by domain
- `reference-architectures/` - Project kickoff templates
- `SUMMARY.md` - Navigation structure

```bash
just setup    # One-time tool installation
just serve    # Preview locally (port 8080)
just build    # Build website and print view
```
