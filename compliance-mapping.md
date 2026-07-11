# Compliance Mapping

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

This mapping uses stable cyber security capability terms to show how
Architecture Decision Records (ADRs) support WA Government cyber security
outcomes. It intentionally avoids policy clause numbers, which can change
between policy releases without changing the underlying security outcome.

## Authoritative WA Sources

Read the current requirements and applicability from these sources:

- [WA Government Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy)
- [DGov policies and guidance](https://www.wa.gov.au/organisation/department-of-the-premier-and-cabinet/office-of-digital-government/policies-and-guidance)
- [DGov Cyber Security Unit](https://www.wa.gov.au/organisation/department-of-the-premier-and-cabinet/office-of-digital-government/cyber-security-unit)
- [WA Cyber Security Unit technical guidance](https://soc.cyber.wa.gov.au/)

The capability name is the durable link between policy intent and technical
decisions. Agencies should record the exact policy release and applicable
clauses in their compliance plan, assurance assessment, or risk system. This
keeps shared ADRs stable while retaining point-in-time audit traceability.

## How to Use This Mapping

- Match obligations to the closest capability term, then apply all relevant
  ADRs and current WA guidance.
- `Strong` means the ADR contains substantial, testable technical
  requirements for the capability. `Partial` means material requirements
  remain outside the ADR. `Gap` means no current ADR provides a reusable
  technical baseline. `Organisational` means the outcome belongs primarily
  in an agency policy, process, contract, or risk record.
- A `Proposed` ADR is not accepted guidance.
- Implementing agencies must retain the evidence named in each ADR and
  evidence for requirements that sit outside this repository.
- Where a primary protection cannot be implemented, record compensating
  protections, residual risk, accountable executive approval, expiry date,
  and reassessment date in the agency risk system.

## Core Protection Capabilities

| Capability | Supporting ADRs | Coverage | Existing support and remaining gap |
|------------|-----------------|----------|------------------------------------|
| Application patching | [ADR 004: CI/CD](development/004-cicd.md), [ADR 009: Release Standards](development/009-release.md) | Partial | Provides build scanning, artifact inventory, release gates, and hotfix evidence. Estate-wide application discovery, scan cadence, remediation timeframes, and unsupported-application removal remain agency obligations. |
| Operating system patching | [ADR 010: Infrastructure as Code](operations/010-configmgmt.md), [ADR 004: CI/CD](development/004-cicd.md) | Partial | Provides supported-version gates, secure configuration deployment, and drift evidence for managed infrastructure. Device and server inventory, scan cadence, patch deployment, and end-of-support transition are not fully covered. |
| Multi-factor authentication | [ADR 013: Identity Federation](security/013-identity-federation.md), [ADR 012: Privileged Remote Access](security/012-privileged-remote-access.md) | Partial | Requires risk-based MFA, phishing-resistant target methods, legacy-authentication removal, and strong privileged MFA. Full agency service coverage and identity lifecycle governance remain outside these ADRs. |
| Privileged access management | [ADR 012: Privileged Remote Access](security/012-privileged-remote-access.md), [ADR 013: Identity Federation](security/013-identity-federation.md) | Strong | Requires dedicated identities, secure administration, just-in-time approval, expiry, quarterly review, break-glass access, session recording, and evidence. Agencies still own personnel authorisation and residual-risk approval. |
| Application control | None | Gap | Current CI/CD controls released artifacts but does not control execution across managed endpoints. |
| Office macro security | None | Gap | No current ADR defines managed macro protections. |
| User application hardening | [ADR 016: Edge Protection](security/016-edge-protection.md) | Gap | Browser-facing service headers support defence in depth, but no ADR defines managed browser, Office, PDF, or endpoint application configuration. |
| Backup and recovery | [ADR 014: Independent Backups and Recovery](operations/014-object-backup.md) | Strong | Defines independent, immutable, encrypted, monitored, and tested recovery for critical service data and configuration. Agency continuity governance and platform-specific implementation remain separate obligations. |
| Server and workload hardening | [ADR 010: Infrastructure as Code](operations/010-configmgmt.md), [ADR 016: Edge Protection](security/016-edge-protection.md), [ADR 004: CI/CD](development/004-cicd.md) | Partial | Provides baseline-as-code, supported versions, drift checks, artifact assurance, origin protection, and WAF protections. Detailed operating system, database, domain-controller, and platform-specific hardening remains outside the ADRs. |
| Email authenticity and anti-spoofing | [ADR 008: Email Authentication](security/008-email-authentication.md) | Strong | Requires domain inventory, SPF, DKIM, DMARC reject progression, parked-domain protections, inbound evaluation, monitoring, testing, and evidence. |
| Secure network architecture | [ADR 001: Application Isolation](security/001-isolation.md), [ADR 006: Automated Policy Enforcement](operations/006-policy-enforcement.md), [ADR 016: Edge Protection](security/016-edge-protection.md), [ADR 021: Workload mTLS and Service Authorisation](security/021-workload-mtls.md) | Partial | Requires trust boundaries, default-deny segmentation, approved flows, origin protection, logging, controlled egress, protective DNS, and proposed identity-based mTLS for Kubernetes east-west traffic. ADRs 006 and 021 remain proposed; enterprise and legacy network implementation remains agency-specific. |
| Continuous detection and response | [ADR 007: Centralised Security Logging](operations/007-logging.md) | Strong | Requires broad log collection, time synchronisation, tamper protection, collection health, continuous analysis, triage, testing, and WA SOC integration. Agency incident plans, staffing, and exercises remain separate obligations. |
| Risk-selected protections | All applicable ADRs | Risk-dependent | Use the agency cyber security context and risk assessment to select additional protections. The ADR catalogue does not replace that assessment or executive acceptance of residual risk. |

## Enterprise and Specialised Protection Capabilities

| Capability | Supporting ADRs | Coverage | Existing support and remaining gap |
|------------|-----------------|----------|------------------------------------|
| Cyber security awareness and role-based training | None | Organisational | Awareness and role-specific training belong in workforce policy, learning records, and capability plans rather than an ADR. |
| Enterprise mobility and secure remote work | [ADR 013: Identity Federation](security/013-identity-federation.md), [ADR 012: Privileged Remote Access](security/012-privileged-remote-access.md) | Gap | Authentication and secure administration support remote access, but no current ADR defines mobile device management, BYO device isolation, compliance, remote wipe, or travel profiles. |
| Procurement and supply chain security | [ADR 004: CI/CD](development/004-cicd.md), [ADR 011: AI Tool and Agent Governance](security/011-ai-governance.md) | Organisational, Partial | SBOM, provenance, dependency verification, and AI supplier assessment support technical due diligence. Supplier assessment, foreign influence, insurance, contractual obligations, and subcontractor governance remain procurement responsibilities. |
| Data offshoring and processing location | [ADR 011: AI Tool and Agent Governance](security/011-ai-governance.md), [ADR 006: Automated Policy Enforcement](operations/006-policy-enforcement.md) | Partial | AI processing-location assessment and proposed geographic guardrails support the capability. Classification, Tier 1 decisions, formal offshoring assessment, approval, and whole-of-service supplier review remain agency obligations. |
| Secure data removal and device disposal | None | Organisational, Gap | Sanitisation standards, custody, destruction, verification, and disposal records require an agency asset and media procedure. |
| Vulnerability management | [ADR 004: CI/CD](development/004-cicd.md), [ADR 009: Release Standards](development/009-release.md), [ADR 010: Infrastructure as Code](operations/010-configmgmt.md) | Partial | Provides artifact scans, continuous rescanning, supported-version protections, release evidence, and exception links. Estate inventory, scanning operations, prioritisation, remediation governance, and executive risk acceptance remain outside the ADRs. |
| Identity and access management | [ADR 013: Identity Federation](security/013-identity-federation.md), [ADR 012: Privileged Remote Access](security/012-privileged-remote-access.md), [ADR 005: Secrets Management](security/005-secrets-management.md) | Partial | Covers federation, authentication, privileged access, application secrets, audit, and evidence. Joiner/mover/leaver automation, customer and service-account lifecycle, password filtering, and agency-wide entitlement reviews remain gaps. |
| Physical security of technology assets | None | Organisational | Facilities access, surveillance, environmental protection, inherited cloud protections, and physical testing are outside this ADR catalogue. |
| Personnel security and access lifecycle | [ADR 012: Privileged Remote Access](security/012-privileged-remote-access.md) | Organisational, Partial | Technical access approval, review, and expiry support personnel security. Vetting, contractor management, employment obligations, and separation processes remain agency responsibilities. |
| Encryption and secrets protection | [ADR 005: Secrets Management](security/005-secrets-management.md), [ADR 014: Independent Backups and Recovery](operations/014-object-backup.md), [ADR 016: Edge Protection](security/016-edge-protection.md), [ADR 021: Workload mTLS and Service Authorisation](security/021-workload-mtls.md) | Partial | Covers secret encryption, encrypted backups, transport protection at web edges, and proposed Kubernetes workload mTLS. No current ADR provides an agency-wide cryptographic algorithm, key, certificate, or data-at-rest standard. |
| Cryptographic agility and post-quantum transition | None | Gap | ADR 005 explicitly excludes an agency cryptographic inventory and post-quantum transition standard. |
| Secure software development | [ADR 004: CI/CD](development/004-cicd.md), [ADR 009: Release Standards](development/009-release.md), [ADR 010: Infrastructure as Code](operations/010-configmgmt.md), [ADR 003: APIs](development/003-apis.md) | Partial | Provides environment and role separation, automated tests and scans, immutable promotion, provenance, secure configuration, and release evidence. Threat modelling, non-production data protection, and broader secure development governance remain agency obligations. |
| Artificial intelligence security | [ADR 011: AI Tool and Agent Governance](security/011-ai-governance.md) | Strong | Requires classification, public-AI restrictions, supplier and offshoring assessment, least privilege, isolation, logging, retention consideration, human oversight, and exception evidence. Enterprise AI still requires project-specific privacy, procurement, and risk assessment. |
| Operational technology and industrial control systems | [ADR 001: Application Isolation](security/001-isolation.md), [ADR 007: Centralised Security Logging](operations/007-logging.md) | Gap | Generic segmentation and logging principles apply, but no current ADR addresses operational technology safety, inventory, remote access, firmware, patch constraints, or IT-OT monitoring. |
| Internet of Things security | [ADR 001: Application Isolation](security/001-isolation.md), [ADR 006: Automated Policy Enforcement](operations/006-policy-enforcement.md) | Gap | Generic isolation and proposed network policy support defence in depth, but procurement, lifecycle, identity, firmware, and device-management requirements are not covered. |
| Cyber risk financing and insurance | None | Organisational | Insurance and self-insurance are financial risk decisions, not reusable architecture decisions. |
| Whole-of-government cyber direction and threat advice | [ADR 006: Automated Policy Enforcement](operations/006-policy-enforcement.md), [ADR 007: Centralised Security Logging](operations/007-logging.md) | Organisational, Partial | Proposed automated guardrails and WA SOC integration can implement technical directions. Governance, action tracking, and formal exemption requests remain agency responsibilities. |

## Evidence Summary

Implementing teams should assemble evidence by service rather than relying on
this mapping alone:

- Asset, identity, domain, supplier, data-flow, log-source, backup, secret,
  and released-artifact inventories
- Version-controlled configurations and policy exports
- Scan, test, restore, detection, access-review, and incident records
- Remediation plans and dated exception records
- Executive approvals for residual risk where primary protections are absent

## Other Framework Associations

The ADRs also reference Australian Cyber Security Centre (ACSC) guidance,
the WA Government AI Policy and Assurance Framework, privacy obligations,
and the Digital ID Act 2024. These references provide design context.
Detailed compliance claims should only be added where an ADR contains a
matching normative requirement and named implementation evidence.

| Framework | Supporting ADRs | Scope and limitation |
|-----------|-----------------|----------------------|
| ACSC Information Security Manual | [ADR 001: Isolation](security/001-isolation.md), [ADR 004: CI/CD](development/004-cicd.md), [ADR 005: Secrets Management](security/005-secrets-management.md), [ADR 007: Logging](operations/007-logging.md), [ADR 008: Email Authentication](security/008-email-authentication.md), [ADR 010: Infrastructure as Code](operations/010-configmgmt.md), [ADR 012: Privileged Remote Access](security/012-privileged-remote-access.md), [ADR 013: Identity Federation](security/013-identity-federation.md), [ADR 016: Edge Protection](security/016-edge-protection.md) | These ADRs implement selected networking, software development, secrets, monitoring, email, hardening, privileged access, authentication, and gateway practices. They do not implement the complete ISM or prove conformance with individual ISM requirements. |
| WA Government AI Policy and Assurance Framework | [ADR 011: AI Tool and Agent Governance](security/011-ai-governance.md), [ADR 015: Data Pipeline Contracts, Quality and Lineage](operations/015-data-governance.md) | Supports technical AI approval, data handling, human oversight, logging, schema, lineage, and quality protections. Accountable Officer nomination, assurance assessment, and referral remain organisational obligations. |
| Privacy and Responsible Information Sharing | [ADR 007: Logging](operations/007-logging.md), [ADR 011: AI Tool and Agent Governance](security/011-ai-governance.md), [ADR 015: Data Pipeline Contracts, Quality and Lineage](operations/015-data-governance.md) | Supports minimisation of logged and AI-disclosed personal information plus data-quality evidence. Privacy assessment, authority, consent, retention, and information-sharing governance remain outside these ADRs. |
| Digital ID Act 2024 | [ADR 013: Identity Federation](security/013-identity-federation.md) | Supports secure OIDC federation and authentication evidence. It does not itself implement voluntary participation, identifier, biometric, accreditation, or privacy safeguards. |

## National Guidance

- [ACSC Essential Eight](https://www.cyber.gov.au/business-government/asds-cyber-security-frameworks/essential-eight)
- [ACSC Essential Eight Maturity Model](https://www.cyber.gov.au/business-government/asds-cyber-security-frameworks/essential-eight/essential-eight-maturity-model)
- [ACSC Information Security Manual guidance](https://www.cyber.gov.au/business-government/asds-cyber-security-frameworks/ism/cyber-security-guidelines)
