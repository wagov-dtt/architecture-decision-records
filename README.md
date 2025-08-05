# Architecture Decision Records

Architecture Decision Records (ADRs) for Office of Digital Government (DGOV) Digital Transformation and Technology Unit (DTT) infrastructure and platform operations.

**Quick Start:** [Open in Codespaces](https://codespaces.new/wagov-dtt/architecture-decision-records) → `just next-number` → Create ADR → `just validate` → Submit PR

[**View Full Documentation**](https://wagov-dtt.github.io/architecture-decision-records/) | [**Download PDF**](https://github.com/wagov-dtt/architecture-decision-records/releases/latest)

## ADR Index

<!-- ADR_INDEX_START -->

| ADR | Title | Status |
|-----|-------|--------|
| [ADR 001](security/001-isolation.qmd) | Application Isolation | Accepted |
| [ADR 002](operations/002-workloads.qmd) | AWS EKS for Cloud Workloads | Accepted |
| [ADR 003](development/003-apis.qmd) | API Documentation Standards | Accepted |
| [ADR 004](development/004-cicd.qmd) | CI/CD Quality Assurance | Accepted |
| [ADR 005](security/005-secrets-management.qmd) | Secrets Management | Accepted |
| [ADR 006](operations/006-policy-enforcement.qmd) | Automated Policy Enforcement | Proposed |
| [ADR 007](operations/007-logging.qmd) | Centralised Security Logging | Accepted |
| [ADR 008](security/008-email-authentication.qmd) | Email Authentication Protocols | Proposed |
| [ADR 009](development/009-release.qmd) | Release Documentation Standards | Accepted |
| [ADR 010](operations/010-configmgmt.qmd) | Infrastructure as Code | Accepted |
| [ADR 011](security/011-ai-governance.qmd) | AI Tool Governance | Proposed |
| [ADR 012](security/012-privileged-remote-access.qmd) | Privileged Remote Access | Proposed |
| [ADR 013](security/013-identity-federation.qmd) | Identity Federation Standards | Proposed |
| [ADR 014](operations/014-object-backup.qmd) | Object Storage Backups | Proposed |
| [ADR 015](operations/015-data-governance.qmd) | Data Governance Standards | Proposed |
| [ADR 016](security/016-edge-protection.qmd) | Web Application Edge Protection | Proposed |
| [ADR 017](operations/017-analytics-tooling.qmd) | Analytics Tooling Standards | Proposed |
| [ADR 018](operations/018-database-patterns.qmd) | Database Patterns | Proposed |

### Reference Architectures

| Reference | Title | Status |
|-----------|-------|--------|
| [Content Management](reference-architectures/content-management.qmd) | Content Management | Proposed |
| [Data Pipelines](reference-architectures/data-pipelines.qmd) | Data Pipelines | Proposed |
| [Identity Management](reference-architectures/identity-management.qmd) | Identity Management | Proposed |
| [Openapi Backends](reference-architectures/openapi-backends.qmd) | OpenAPI Backend | Proposed |

<!-- ADR_INDEX_END -->

## Quick Reference

### Creating ADRs

```bash
just next-number          # Get next ADR number
just validate            # Check format and quality  
just serve              # Preview website locally
just clean              # Remove generated files
```

### ADR Template

```markdown
---
title: "ADR ###: Your Decision Title"
date: 2025-07-22
status: Proposed
tags: [category, technology]
---

**Status:** {{< meta status >}} | **Date:** {{< meta date >}}

## Context
What problem are we solving?

## Decision  
What did we decide and why?

## Consequences
What are the trade-offs and risks?
```

## Title Examples

**Good:** "ADR 008: Email Authentication", "ADR 016: Edge Protection", "ADR 006: Policy Enforcement"  
**Bad:** "Database stuff", "Security improvements", "Frontend updates"

## Development Commands

| Command | Purpose |
|---------|---------|
| `just next-number` | Get next ADR number to use |
| `just validate` | Check format and prose quality |
| `just serve` | Preview website locally |
| `just build` | Generate final website/PDF |
| `just clean` | Remove generated files |

See [CONTRIBUTING.md](CONTRIBUTING.md) for complete workflow and quality standards.

## Automated Deployment

**Website:** Automatically deploys to GitHub Pages on every push to `main`  
**PDF Releases:** Automatically attached to GitHub releases when published

### Manual Deployment

```bash
just build    # Build website and PDF locally
```

## Related Resources

- [Architecture Principles](./architecture-principles.qmd) - Guide all decisions
- [DGOV DevSecOps Training](https://soc.cyber.wa.gov.au/training/devsecops-induction/) - Supporting material
- [WA Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy) - Compliance framework
