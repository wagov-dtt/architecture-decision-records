---
title: "WA Government Architecture Decision Records"
description: "Reusable architecture patterns for WA Government digital services, maintained by the Office of Digital Government (DGOV) Digital Transformation and Technology Unit (DTT)."
weight: 1
hideBreadcrumb: true
toc: true
---

## WA Government Architecture Decision Records

Reusable architecture patterns for WA Government digital services, maintained by the Office of Digital Government (DGOV) Digital Transformation and Technology Unit (DTT).

### For WA Public Sector Agencies

These patterns help you build secure, compliant digital services faster. Instead of starting from scratch, use proven approaches that align with WA Government security and compliance requirements.

#### Getting Started

1. **Review the [Architecture Principles](/architecture-principles.html)** - Six guiding principles for all technology decisions
2. **Choose a Reference Architecture** - Project kickoff templates combining multiple decisions:
   - [Content Management](/reference-architectures/content-management.html) - Websites, intranets, and content portals
   - [Data Pipelines](/reference-architectures/data-pipelines.html) - Analytics, reporting, and data processing
   - [Identity Management](/reference-architectures/identity-management.html) - User authentication and single sign-on
   - [OpenAPI Backends](/reference-architectures/openapi-backends.html) - Backend services and integrations
3. **Check the [Compliance Mapping](/compliance-mapping.html)** - Find which ADRs apply to your security and compliance requirements

#### Compliance Alignment

These ADRs align with:

- [WA Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy)
- [ACSC Information Security Manual (ISM)](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)
- [WA Government AI Policy and Assurance Framework](https://www.wa.gov.au/government/publications/wa-government-artificial-intelligence-policy-and-assurance-framework)

Supporting training: [DGOV Technical - DevSecOps Induction](https://soc.cyber.wa.gov.au/training/devsecops-induction/)

**[Browse online](https://adr.dtt.digital.wa.gov.au/)** | **[Printable view](/printable/)**

---

### Contributing

New ADRs document the **context** (problem), **decision** (solution), and **consequences** (trade-offs). See the [Contributing Guide](/CONTRIBUTING.html) for workflow and templates.

For AI-assisted contributions, see the guidance in [CONTRIBUTING.md](/CONTRIBUTING.html).

### Repository Structure

This project uses [Hugo](https://gohugo.io/) and [Hinode](https://gethinode.com/) to generate documentation:

- `content/docs/development/`, `content/docs/operations/`, `content/docs/security/` - ADRs by domain
- `content/docs/reference-architectures/` - Project kickoff templates
- Hugo front matter - Navigation structure

```bash
just setup    # One-time tool installation
just serve    # Preview locally (port 8080)
just build    # Build website and printable view
```
