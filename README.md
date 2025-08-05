# Architecture Decision Records

Architecture Decision Records (ADRs) for Office of Digital Government
(DGOV) Digital Transformation and Technology Unit (DTT) infrastructure
and platform operations.

> **Note:** `.qmd` files are the source of truth. The `.md` files are
> automatically generated from `.qmd` files when running
> `just update-chapters`.

**Quick Start:** [Open in
Codespaces](https://codespaces.new/wagov-dtt/architecture-decision-records)
→ `just next-number` → Create ADR → `just validate` → Submit PR

[**View Full
Documentation**](https://wagov-dtt.github.io/architecture-decision-records/)
\| [**Download
PDF**](https://github.com/wagov-dtt/architecture-decision-records/releases/latest)

## ADR Index

| ADR | Title | Status | Date |
|----|----|----|----|
| [ADR 001](security/001-isolation.md) | ADR 001: Application Isolation | Accepted | 2025-02-17 |
| [ADR 002](operations/002-workloads.md) | ADR 002: AWS EKS for Cloud Workloads | Accepted | 2025-02-17 |
| [ADR 003](development/003-apis.md) | ADR 003: API Documentation Standards | Accepted | 2025-03-26 |
| [ADR 004](development/004-cicd.md) | ADR 004: CI/CD Quality Assurance | Accepted | 2025-03-10 |
| [ADR 005](security/005-secrets-management.md) | ADR 005: Secrets Management | Accepted | 2025-02-25 |
| [ADR 006](operations/006-policy-enforcement.md) | ADR 006: Automated Policy Enforcement | Proposed | 2025-07-29 |
| [ADR 007](operations/007-logging.md) | ADR 007: Centralised Security Logging | Accepted | 2025-02-25 |
| [ADR 008](security/008-email-authentication.md) | ADR 008: Email Authentication Protocols | Proposed | 2025-07-22 |
| [ADR 009](development/009-release.md) | ADR 009: Release Documentation Standards | Accepted | 2025-03-04 |
| [ADR 010](operations/010-configmgmt.md) | ADR 010: Infrastructure as Code | Accepted | 2025-03-10 |
| [ADR 011](security/011-ai-governance.md) | ADR 011: AI Tool Governance | Proposed | 2025-07-29 |
| [ADR 012](security/012-privileged-remote-access.md) | ADR 012: Privileged Remote Access | Proposed | 2025-07-22 |
| [ADR 013](security/013-identity-federation.md) | ADR 013: Identity Federation Standards | Proposed | 2025-07-29 |
| [ADR 014](operations/014-object-backup.md) | ADR 014: Object Storage Backups | Proposed | 2025-07-22 |
| [ADR 015](operations/015-data-governance.md) | ADR 015: Data Governance Standards | Proposed | 2025-07-28 |
| [ADR 016](security/016-edge-protection.md) | ADR 016: Web Application Edge Protection | Proposed | 2025-07-22 |
| [ADR 017](operations/017-analytics-tooling.md) | ADR 017: Analytics Tooling Standards | Proposed | 2025-07-28 |
| [ADR 018](operations/018-database-patterns.md) | ADR 018: Database Patterns | Proposed | 2025-07-28 |

### Reference Architectures

| Reference | Title | Status | Date |
|----|----|----|----|
| [Content Management](reference-architectures/content-management.md) | Reference Architecture: Content Management | Proposed | 2025-07-28 |
| [Data Pipelines](reference-architectures/data-pipelines.md) | Reference Architecture: Data Pipelines | Proposed | 2025-01-28 |
| [Identity Management](reference-architectures/identity-management.md) | Reference Architecture: Identity Management | Proposed | 2025-07-29 |
| [Openapi Backends](reference-architectures/openapi-backends.md) | Reference Architecture: OpenAPI Backend | Proposed | 2025-07-28 |

## Quick Reference

### Creating ADRs

``` bash
just next-number          # Get next ADR number
just validate            # Check format and quality  
just serve              # Preview website locally
just clean              # Remove generated files
```

### ADR Template

``` markdown
---
title: "ADR ###: Your Decision Title"
date: 2025-07-22
status: Proposed
tags: [category, technology]
---

**Status:** ?meta:status | **Date:** ?meta:date

## Context
What problem are we solving?

## Decision  
What did we decide and why?

## Consequences
What are the trade-offs and risks?
```

## Title Examples

**Good:** “ADR 008: Email Authentication”, “ADR 016: Edge Protection”,
“ADR 006: Policy Enforcement”  
**Bad:** “Database stuff”, “Security improvements”, “Frontend updates”

## Development Commands

| Command            | Purpose                        |
|--------------------|--------------------------------|
| `just next-number` | Get next ADR number to use     |
| `just validate`    | Check format and prose quality |
| `just serve`       | Preview website locally        |
| `just build`       | Generate final website/PDF     |
| `just clean`       | Remove generated files         |

See [CONTRIBUTING.md](CONTRIBUTING.md) for complete workflow and quality
standards.

## Automated Deployment

**Website:** Automatically deploys to GitHub Pages on every push to
`main`  
**PDF Releases:** Automatically attached to GitHub releases when
published

### Manual Deployment

``` bash
just build    # Build website and PDF locally
```

## Related Resources

- [Architecture Principles](./architecture-principles.md) - Guide all
  decisions
- [DGOV DevSecOps
  Training](https://soc.cyber.wa.gov.au/training/devsecops-induction/) -
  Supporting material
- [WA Cyber Security
  Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy) -
  Compliance framework
