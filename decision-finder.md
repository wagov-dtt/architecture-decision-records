# Decision Finder

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

Use this page to find the right starting point for common delivery needs.
Start with a reference architecture when one matches the project. Use ADRs
directly when you need a specific decision or control.

Reference architectures display their status at the top of each page. Accepted
architectures are active project-kickoff guidance. Proposed architectures remain
evaluation aids and require explicit project approval, including approval of their
Proposed dependencies.

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

| Project need | Starting point | Status | Then check |
|--------------|----------------|--------|------------|
| Bounded AI assistance with human accountability | [AI-Assisted Digital Services](reference-architectures/ai-assisted-digital-services.md) | Proposed | [ADR 011: AI Tool and Agent Governance](security/011-ai-governance.md), [ADR 007: Logging](operations/007-logging.md) |
| Public website, intranet, content portal, or static publishing | [Content Management](reference-architectures/content-management.md) | Accepted | [ADR 016: Edge Protection](security/016-edge-protection.md), [ADR 013: Identity Federation](security/013-identity-federation.md), [ADR 020: Frontend UI](development/020-frontend-ui-foundations.md) |
| Independently owned apps that may share entry, identity, messaging, or channel capabilities | [Federated Application Portal](reference-architectures/federated-application-portal.md) | Proposed | [Identity Federation](reference-architectures/identity-management.md), [OpenAPI Backends](reference-architectures/openapi-backends.md) |
| Governed batch, streaming, warehouse, lakehouse, or analytical data movement | [Data Pipelines](reference-architectures/data-pipelines.md) | Accepted | [ADR 015: Data Pipeline Quality](operations/015-data-governance.md), [ADR 018: Databases and Lakehouses](operations/018-database-patterns.md) |
| OIDC or legacy SAML federation for workforce, citizen, customer, partner, or privileged users | [Identity Federation](reference-architectures/identity-management.md) | Proposed | [ADR 013: Identity Federation](security/013-identity-federation.md), [ADR 012: Privileged Remote Access](security/012-privileged-remote-access.md) |
| Agency-controlled HTTP API accurately described by OpenAPI | [OpenAPI Backends](reference-architectures/openapi-backends.md) | Accepted | [ADR 003: HTTP API Contracts](development/003-apis.md), [ADR 016: Edge Protection](security/016-edge-protection.md), [ADR 004: CI/CD](development/004-cicd.md) |

## Adoption Bundles

Use these bundles to start project discovery, not as universal control sets. Add
or remove ADRs according to the preflight, selected architecture variant, and
project risk. A `Proposed` reference architecture or ADR still requires explicit
project approval.

### Public Website or Content Service

**Start with:** Accepted [Content Management](reference-architectures/content-management.md).

**Minimum ADR set:** [ADR 020: Frontend UI
Foundations](development/020-frontend-ui-foundations.md), [ADR 016: Edge
Protection](security/016-edge-protection.md), [ADR 004: CI/CD](development/004-cicd.md),
[ADR 009: Release Standards](development/009-release.md), [ADR 007:
Logging](operations/007-logging.md), and [ADR 014: Backups and
Recovery](operations/014-object-backup.md). Add [ADR 013: Identity
Federation](security/013-identity-federation.md) when users or editors sign in.

**Kickoff deliverables:**

- Service and content brief, audiences, critical journeys, content ownership,
  publication workflow, and selected architecture variant
- Accessibility and design-system assessment with representative user testing
- Content, media, URL, redirect, integration, records, and retention inventory
- Edge and origin design, release path, service objectives, support model,
  recovery test, migration plan, and export or exit plan

### Agency-Controlled HTTP API

**Start with:** Accepted [OpenAPI Backends](reference-architectures/openapi-backends.md).

**Minimum ADR set:** [ADR 003: HTTP API Contract
Standards](development/003-apis.md), [ADR 004: CI/CD](development/004-cicd.md),
[ADR 005: Secrets Management](security/005-secrets-management.md), [ADR 007:
Logging](operations/007-logging.md), and [ADR 009: Release
Standards](development/009-release.md). Add [ADR 013: Identity
Federation](security/013-identity-federation.md) for user delegation, [ADR 016:
Edge Protection](security/016-edge-protection.md) for Internet exposure, and
[ADR 014: Backups and Recovery](operations/014-object-backup.md) for stateful
services.

**Kickoff deliverables:**

- Version-controlled OpenAPI contract, named consumers, ownership, lifecycle,
  compatibility policy, and deprecation plan
- Exposure and trust-boundary diagram, authentication and operation or resource
  authorisation model, data classification, limits, and abuse cases
- Contract, behaviour, security, compatibility, and failure test plan
- Service objectives, monitoring, support and incident runbooks, recovery plan,
  consumer migration plan, and provider-exit record

### Data Pipeline or Analytical Data Service

**Start with:** Accepted [Data Pipelines](reference-architectures/data-pipelines.md).

**Minimum ADR set:** [ADR 015: Data Pipeline
Quality](operations/015-data-governance.md), [ADR 018: Databases and
Lakehouses](operations/018-database-patterns.md), [ADR 004:
CI/CD](development/004-cicd.md), [ADR 005: Secrets
Management](security/005-secrets-management.md), [ADR 007:
Logging](operations/007-logging.md), [ADR 010: Infrastructure as
Code](operations/010-configmgmt.md), and [ADR 014: Backups and
Recovery](operations/014-object-backup.md). Add [ADR 017: Analytical
Publications](operations/017-analytics-tooling.md) for bounded publications and
Proposed [ADR 021: Workload mTLS](security/021-workload-mtls.md) when approved
for Kubernetes-hosted pipeline services.

**Kickoff deliverables:**

- Source, consumer, authority, purpose, classification, sharing, retention, and
  processing-location record
- Versioned data contracts, data-flow diagram, quality thresholds, lineage
  design, quarantine, replay, and reconciliation approach
- Freshness and service objectives, capacity and cost forecast, RTO, RPO,
  support model, and incident runbooks
- Representative quality, lineage, performance, recovery, migration,
  interoperability, and exit tests

### AI-Assisted Service or Workflow

**Start with:** Proposed [AI-Assisted Digital
Services](reference-architectures/ai-assisted-digital-services.md), with explicit
project approval, and [ADR 011: AI Tool and Agent
Governance](security/011-ai-governance.md).

**Minimum ADR set:** [ADR 011: AI Tool and Agent
Governance](security/011-ai-governance.md), [ADR 001: Application
Isolation](security/001-isolation.md), [ADR 005: Secrets
Management](security/005-secrets-management.md), and [ADR 007:
Logging](operations/007-logging.md). Add [ADR 004: CI/CD](development/004-cicd.md)
for released software and the ADRs required by the authoritative source service.

**Kickoff deliverables:**

- Bounded use case, excluded uses, risk tier, accountable human, human decision
  boundary, and non-AI fallback
- Information classification, privacy, records, supplier, processing-location,
  offshoring, retention, and threat assessments
- Representative evaluation set with quality, safety, accessibility, security,
  refusal, and human-review acceptance thresholds
- Prompt and model change controls, monitoring and incident runbook, usage and
  cost limits, data and configuration export, and provider-exit test

### Federated Application Set

**Start with:** Proposed [Federated Application
Portal](reference-architectures/federated-application-portal.md), with explicit
project approval. Select only shared capabilities with demonstrated user or
operational value.

**Minimum ADR set:** [ADR 013: Identity
Federation](security/013-identity-federation.md), [ADR 003: HTTP API
Contracts](development/003-apis.md) for shared APIs, [ADR 020: Frontend UI
Foundations](development/020-frontend-ui-foundations.md), [ADR 005: Secrets
Management](security/005-secrets-management.md), and [ADR 007:
Logging](operations/007-logging.md). Add [ADR 012: Privileged Remote
Access](security/012-privileged-remote-access.md) for administration and [ADR
016: Edge Protection](security/016-edge-protection.md) for Internet-facing
capabilities.

**Kickoff deliverables:**

- Selected shared capabilities, accountable boundaries, funding and support
  model, application inventory, direct-access paths, and degraded modes
- Cross-application journeys, accessibility and assisted-digital needs, identity
  assurance, claim definitions, and application-owned authorisation model
- Versioned API, message, SDK, component, and native-bridge contracts where used
- Trust-boundary and data-flow diagrams, service objectives, onboarding and
  offboarding checks, resilience tests, migration plan, and exit plan

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

## ADR Catalogue

This generated catalogue is the authoritative index of ADR status, review dates,
and direct dependencies. Dependencies come from each ADR's synopsis; update the
source ADR and run `just update-catalogue` rather than editing this table.

<!-- generated-adr-catalogue:start -->

| ADR | Domain | Status | Decision date | Review date | Dependencies |
|-----|--------|--------|---------------|-------------|--------------|
| [ADR 001: Application Isolation](security/001-isolation.md) | Security | Accepted | 2026-07-11 | 2027-07-11 | [ADR 021 (Proposed)](security/021-workload-mtls.md), [ADR 006 (Proposed)](operations/006-policy-enforcement.md), [ADR 007](operations/007-logging.md) |
| [ADR 002: Managed Kubernetes for Compatible Workloads](operations/002-workloads.md) | Operations | Accepted | 2026-07-11 | 2027-07-11 | [ADR 018](operations/018-database-patterns.md), [ADR 019](operations/019-shared-file-access.md), [ADR 021 (Proposed)](security/021-workload-mtls.md) |
| [ADR 003: HTTP API Contract Standards](development/003-apis.md) | Development | Accepted | 2026-07-11 | 2027-07-11 | None |
| [ADR 004: CI/CD Quality Assurance](development/004-cicd.md) | Development | Accepted | 2026-07-11 | 2027-07-11 | [ADR 003](development/003-apis.md), [ADR 010](operations/010-configmgmt.md) |
| [ADR 005: Secrets Management](security/005-secrets-management.md) | Security | Accepted | 2026-07-11 | 2027-07-11 | None |
| [ADR 006: Automated Policy Enforcement](operations/006-policy-enforcement.md) | Operations | Proposed | 2026-07-11 | 2027-07-11 | [ADR 021 (Proposed)](security/021-workload-mtls.md), [ADR 010](operations/010-configmgmt.md), [ADR 007](operations/007-logging.md) |
| [ADR 007: Centralised Security Logging](operations/007-logging.md) | Operations | Accepted | 2026-07-11 | 2027-07-11 | None |
| [ADR 008: Email Authentication Protocols](security/008-email-authentication.md) | Security | Accepted | 2026-07-11 | 2027-07-11 | None |
| [ADR 009: Release Standards](development/009-release.md) | Development | Accepted | 2026-07-11 | 2027-07-11 | [ADR 007](operations/007-logging.md) |
| [ADR 010: Infrastructure and Configuration as Code](operations/010-configmgmt.md) | Operations | Accepted | 2026-07-11 | 2027-07-11 | [ADR 009](development/009-release.md) |
| [ADR 011: AI Tool and Agent Governance](security/011-ai-governance.md) | Security | Accepted | 2026-07-11 | 2027-07-11 | [ADR 001](security/001-isolation.md) |
| [ADR 012: Privileged Remote Access](security/012-privileged-remote-access.md) | Security | Accepted | 2026-07-11 | 2027-07-11 | [ADR 007](operations/007-logging.md), [ADR 010](operations/010-configmgmt.md) |
| [ADR 013: Identity Federation Standards](security/013-identity-federation.md) | Security | Accepted | 2026-07-11 | 2027-07-11 | [ADR 012](security/012-privileged-remote-access.md), [ADR 007](operations/007-logging.md) |
| [ADR 014: Independent Backups and Recovery](operations/014-object-backup.md) | Operations | Accepted | 2026-07-11 | 2027-07-11 | None |
| [ADR 015: Data Pipeline Contracts, Quality and Lineage](operations/015-data-governance.md) | Operations | Accepted | 2026-07-11 | 2027-07-11 | [ADR 007](operations/007-logging.md) |
| [ADR 016: Web Application Edge Protection](security/016-edge-protection.md) | Security | Accepted | 2026-07-11 | 2027-07-11 | [ADR 019](operations/019-shared-file-access.md), [ADR 007](operations/007-logging.md) |
| [ADR 017: Reproducible Analytical Publications](operations/017-analytics-tooling.md) | Operations | Accepted | 2026-07-11 | 2027-07-11 | [ADR 016](security/016-edge-protection.md) |
| [ADR 018: Managed Relational Databases and Open Lakehouses](operations/018-database-patterns.md) | Operations | Accepted | 2026-07-11 | 2027-07-11 | [ADR 014](operations/014-object-backup.md) |
| [ADR 019: Shared File Access](operations/019-shared-file-access.md) | Operations | Accepted | 2026-07-11 | 2027-07-11 | [ADR 016](security/016-edge-protection.md), [ADR 014](operations/014-object-backup.md) |
| [ADR 020: Frontend UI Foundations](development/020-frontend-ui-foundations.md) | Development | Accepted | 2026-07-11 | 2027-07-11 | None |
| [ADR 021: Workload mTLS and Service Authorisation](security/021-workload-mtls.md) | Security | Proposed | 2026-07-11 | 2027-07-11 | [ADR 001](security/001-isolation.md), [ADR 006 (Proposed)](operations/006-policy-enforcement.md), [ADR 010](operations/010-configmgmt.md), [ADR 007](operations/007-logging.md) |

<!-- generated-adr-catalogue:end -->

## Quality Checks Before Delivery

Before using a decision in a project kickoff, confirm that:

- The ADR or reference architecture is not superseded
- Accepted ADRs are used as active decisions; Proposed material has explicit
  project approval and does not silently establish a standard
- The review date has not passed, or the decision owner accepts the risk
- Compliance obligations are checked in [Compliance Mapping](compliance-mapping.md)
- Related ADRs have been reviewed together, not in isolation
- Project-specific deviations are documented in the project record
