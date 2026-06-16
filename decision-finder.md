# Decision Finder

**Status:** Accepted | **Date:** 2026-06-09 | **Review:** 2027-06-09

Use this page to find the right starting point for common delivery needs.
Start with a reference architecture when one matches the project. Use ADRs
directly when you need a specific decision or control.

## Start by Project Type

| Project need | Start here | Then check |
|--------------|------------|------------|
| Public website, intranet, or content portal | [Content Management](reference-architectures/content-management.md) | [ADR 016: Edge Protection](security/016-edge-protection.md), [ADR 013: Identity Federation](security/013-identity-federation.md), [ADR 015: Data Governance](operations/015-data-governance.md) |
| Multiple standalone web apps sharing central account, identity, notification, SDK, or mobile-webview services | [Federated Application Portal](reference-architectures/federated-application-portal.md) | [Identity Management](reference-architectures/identity-management.md), [OpenAPI Backends](reference-architectures/openapi-backends.md), [ADR 016: Edge Protection](security/016-edge-protection.md) |
| Data integration, analytics, reporting, or batch processing | [Data Pipelines](reference-architectures/data-pipelines.md) | [ADR 015: Data Governance](operations/015-data-governance.md), [ADR 018: Database Patterns](operations/018-database-patterns.md), [ADR 017: Analytics Tooling](operations/017-analytics-tooling.md) |
| Login, single sign-on, Digital ID, or verifiable credentials | [Identity Management](reference-architectures/identity-management.md) | [ADR 013: Identity Federation](security/013-identity-federation.md), [ADR 012: Privileged Remote Access](security/012-privileged-remote-access.md), [ADR 007: Logging](operations/007-logging.md) |
| Backend service, integration API, or mobile/web API | [OpenAPI Backends](reference-architectures/openapi-backends.md) | [ADR 003: APIs](development/003-apis.md), [ADR 016: Edge Protection](security/016-edge-protection.md), [ADR 004: CI/CD](development/004-cicd.md) |

## Start by Capability

| Capability | Primary ADRs |
|------------|--------------|
| Application isolation and boundaries | [ADR 001: Isolation](security/001-isolation.md) |
| Cloud workloads and runtime hosting | [ADR 002: Workloads](operations/002-workloads.md) |
| API contracts and documentation | [ADR 003: APIs](development/003-apis.md) |
| Build, test, and deployment automation | [ADR 004: CI/CD](development/004-cicd.md), [ADR 009: Release Standards](development/009-release.md) |
| Secrets and credential handling | [ADR 005: Secrets Management](security/005-secrets-management.md) |
| Policy-as-code and guardrails | [ADR 006: Policy Enforcement](operations/006-policy-enforcement.md) |
| Centralised logging and monitoring | [ADR 007: Logging](operations/007-logging.md) |
| Email domains and anti-spoofing | [ADR 008: Email Authentication](security/008-email-authentication.md) |
| Infrastructure as code | [ADR 010: Config Management](operations/010-configmgmt.md) |
| AI tools and agents | [ADR 011: AI Tool and Agent Governance](security/011-ai-governance.md) |
| Privileged access | [ADR 012: Privileged Remote Access](security/012-privileged-remote-access.md) |
| Identity federation | [ADR 013: Identity Federation](security/013-identity-federation.md) |
| Object storage backup and recovery | [ADR 014: Object Backup](operations/014-object-backup.md) |
| Data ownership, quality, and retention | [ADR 015: Data Governance](operations/015-data-governance.md) |
| CDN, WAF, and edge protection | [ADR 016: Edge Protection](security/016-edge-protection.md) |
| Analytics reports and dashboards | [ADR 017: Analytics Tooling](operations/017-analytics-tooling.md) |
| Database and lakehouse patterns | [ADR 018: Database Patterns](operations/018-database-patterns.md) |
| Shared file access | [ADR 019: Shared File Access](operations/019-shared-file-access.md) |

## Quality Checks Before Delivery

Before using a decision in a project kickoff, confirm that:

- The ADR or reference architecture is not superseded
- The review date has not passed, or the decision owner accepts the risk
- Compliance obligations are checked in [Compliance Mapping](compliance-mapping.md)
- Related ADRs have been reviewed together, not in isolation
- Project-specific deviations are documented in the project record
