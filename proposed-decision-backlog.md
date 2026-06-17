# Proposed Decision Backlog

**Status:** Accepted | **Date:** 2026-06-09 | **Review:** 2027-06-09

This backlog tracks guidance that is useful but not yet accepted as an active
decision. Use it during annual reviews and planning to decide whether each
item should move to `Accepted`, stay `Proposed`, or become `Superseded`.

## Proposed ADRs

| Document | Current status | Next review | Review focus |
|----------|----------------|-------------|--------------|
| [ADR 006: Policy Enforcement](operations/006-policy-enforcement.md) | Proposed | 2026-07-29 | Confirm policy-as-code scope, required tools, and enforcement boundaries |
| [ADR 014: Object Backup](operations/014-object-backup.md) | Proposed | 2026-07-22 | Confirm recovery objectives, object lock posture, and lifecycle guidance |
| [ADR 015: Data Governance](operations/015-data-governance.md) | Proposed | 2026-07-28 | Confirm ownership, classification, retention, and AI data-quality obligations |
| [ADR 017: Analytics Tooling](operations/017-analytics-tooling.md) | Proposed | 2026-07-28 | Confirm Quarto use cases, publishing model, and dashboard boundaries |
| [ADR 018: Database Patterns](operations/018-database-patterns.md) | Proposed | 2026-07-28 | Confirm managed database, lakehouse, and local development patterns |
| [ADR 020: Frontend UI Foundations](development/020-frontend-ui-foundations.md) | Proposed | 2027-06-17 | Validate Bootstrap 5-compatible baseline, agency design-system fit, CMS and portal integration assumptions |

## Proposed Reference Architectures

| Document | Current status | Next review | Review focus |
|----------|----------------|-------------|--------------|
| [AI-Assisted Digital Services](reference-architectures/ai-assisted-digital-services.md) | Proposed | 2027-06-17 | Validate Open Responses gateway, Bedrock Mantle backend, data minimisation, human accountability, and initial CMS authoring use case |
| [Content Management](reference-architectures/content-management.md) | Proposed | 2026-07-28 | Validate CMS, CDN, WAF, editorial workflow, and media-storage assumptions |
| [Data Pipelines](reference-architectures/data-pipelines.md) | Proposed | 2026-01-28 | Validate object-storage lakehouse, DuckDB/DuckLake, S3 Tables, and reporting flow |
| [Federated Application Portal](reference-architectures/federated-application-portal.md) | Proposed | 2027-06-16 | Validate SDK scope, cross-organisation ownership, PWA support, mobile-webview handoff, and central service boundaries |
| [Identity Management](reference-architectures/identity-management.md) | Proposed | 2026-07-29 | Validate broker pattern, managed identity platform use, and Digital ID assumptions |
| [OpenAPI Backends](reference-architectures/openapi-backends.md) | Proposed | 2026-07-28 | Validate public/admin API separation, contract testing, and edge controls |

## Acceptance Criteria

Move a proposed item to `Accepted` when:

- The scope and non-goals are clear enough for delivery teams to apply
- Required related ADRs are linked
- Implementation steps are practical and testable
- Compliance mapping is complete where relevant
- A reviewer confirms the technology and policy assumptions still hold
- The annual `Review` date is set one year after the document `Date`

Keep a proposed item as `Proposed` when the guidance is directionally useful
but still depends on technology, policy, or operating-model confirmation.

Move a proposed item to `Superseded` when another ADR or reference
architecture has replaced it.
