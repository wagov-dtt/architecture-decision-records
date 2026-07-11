# Decision Finder

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

Use this page to find the right starting point for common delivery needs.
Start with a reference architecture when one matches the project. Use ADRs
directly when you need a specific decision or control.

All current reference architectures are **Proposed**. Use them as evaluation and
project-kickoff aids, not active standards. A project must either rely on Accepted
ADRs directly or explicitly approve use of Proposed guidance and its dependencies.

## Project Preflight

Before choosing a pattern, record:

- Users, service outcome, accountable owners, critical journeys, and non-goals
- Existing and legacy constraints, agency capability, support model, and budget
- Information classification, privacy, sharing, records, processing locations,
  suppliers, and offshoring requirements
- Accessibility and assisted-digital needs
- Criticality, service levels, RTO, RPO, degraded operation, and incident coverage
- Migration, interoperability, data/configuration export, rollback, and exit needs

## Start by Project Type

| Project need | Proposed starting point | Then check |
|--------------|-------------------------|------------|
| Bounded AI assistance with human accountability | [AI-Assisted Digital Services](reference-architectures/ai-assisted-digital-services.md) | [ADR 011: AI Tool and Agent Governance](security/011-ai-governance.md), [ADR 007: Logging](operations/007-logging.md) |
| Public website, intranet, content portal, or static publishing | [Content Management](reference-architectures/content-management.md) | [ADR 016: Edge Protection](security/016-edge-protection.md), [ADR 013: Identity Federation](security/013-identity-federation.md), [ADR 020: Frontend UI](development/020-frontend-ui-foundations.md) |
| Independently owned apps that may share entry, identity, messaging, or channel capabilities | [Federated Application Portal](reference-architectures/federated-application-portal.md) | [Identity Federation](reference-architectures/identity-management.md), [OpenAPI Backends](reference-architectures/openapi-backends.md) |
| Governed batch, streaming, warehouse, lakehouse, or analytical data movement | [Data Pipelines](reference-architectures/data-pipelines.md) | [ADR 015: Data Pipeline Quality](operations/015-data-governance.md), [ADR 018: Databases and Lakehouses](operations/018-database-patterns.md) |
| OIDC or legacy SAML federation for workforce, citizen, customer, partner, or privileged users | [Identity Federation](reference-architectures/identity-management.md) | [ADR 013: Identity Federation](security/013-identity-federation.md), [ADR 012: Privileged Remote Access](security/012-privileged-remote-access.md) |
| Agency-controlled HTTP API accurately described by OpenAPI | [OpenAPI Backends](reference-architectures/openapi-backends.md) | [ADR 003: HTTP API Contracts](development/003-apis.md), [ADR 016: Edge Protection](security/016-edge-protection.md), [ADR 004: CI/CD](development/004-cicd.md) |

## Start by Capability

| Capability | Primary ADRs |
|------------|--------------|
| Application isolation and boundaries | [ADR 001: Isolation](security/001-isolation.md) |
| Managed Kubernetes for compatible workloads | [ADR 002: Managed Kubernetes](operations/002-workloads.md) |
| HTTP API contracts and testing | [ADR 003: HTTP API Contracts](development/003-apis.md) |
| AI model access, abstraction, and provider exit assessment | [AI-Assisted Digital Services](reference-architectures/ai-assisted-digital-services.md), [ADR 011: AI Tool and Agent Governance](security/011-ai-governance.md) |
| Build, test, and deployment automation | [ADR 004: CI/CD](development/004-cicd.md), [ADR 009: Release Standards](development/009-release.md) |
| Frontend UI, design-system components, CMS templates, or portal widgets | [ADR 020: Frontend UI Foundations](development/020-frontend-ui-foundations.md) |
| Secrets and credential handling | [ADR 005: Secrets Management](security/005-secrets-management.md) |
| Policy-as-code and guardrails | [ADR 006: Policy Enforcement](operations/006-policy-enforcement.md) |
| Centralised logging and monitoring | [ADR 007: Logging](operations/007-logging.md) |
| Email domains and anti-spoofing | [ADR 008: Email Authentication](security/008-email-authentication.md) |
| Infrastructure and configuration as code | [ADR 010: Infrastructure as Code](operations/010-configmgmt.md) |
| AI tools and agents | [ADR 011: AI Tool and Agent Governance](security/011-ai-governance.md) |
| Privileged access | [ADR 012: Privileged Remote Access](security/012-privileged-remote-access.md) |
| Identity federation | [ADR 013: Identity Federation](security/013-identity-federation.md) |
| Independent backup and recovery | [ADR 014: Backups and Recovery](operations/014-object-backup.md) |
| Data contracts, runtime lineage, and quality | [ADR 015: Data Pipeline Quality](operations/015-data-governance.md) |
| CDN, WAF, and edge protection | [ADR 016: Edge Protection](security/016-edge-protection.md) |
| Reproducible analytical publications | [ADR 017: Analytical Publications](operations/017-analytics-tooling.md) |
| Managed databases and open lakehouses | [ADR 018: Databases and Lakehouses](operations/018-database-patterns.md) |
| Shared file access | [ADR 019: Shared File Access](operations/019-shared-file-access.md) |
| Kubernetes workload identity, mTLS, and service authorisation | [ADR 021: Workload mTLS](security/021-workload-mtls.md) |

## Quality Checks Before Delivery

Before using a decision in a project kickoff, confirm that:

- The ADR or reference architecture is not superseded
- Accepted ADRs are used as active decisions; Proposed material has explicit
  project approval and does not silently establish a standard
- The review date has not passed, or the decision owner accepts the risk
- Compliance obligations are checked in [Compliance Mapping](compliance-mapping.md)
- Related ADRs have been reviewed together, not in isolation
- Project-specific deviations are documented in the project record
