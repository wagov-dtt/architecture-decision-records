---
title: "ADR 014: Object Storage Backups"
date: 2025-07-22
status: Proposed
tags:
- #operations
- #backup
- #storage
- #disaster-recovery
- #compliance
---

## Status

Proposed

## Context

Current backup approaches lack cross-region redundancy and automated lifecycle management, creating single points of failure and compliance risks for government data retention requirements. Traditional storage systems do not provide the durability and geographic distribution needed for critical government systems.

Key challenges:

- Single region backup storage creating vulnerability to regional outages
- Manual backup processes prone to human error
- Lack of automated recovery testing
- Insufficient geographic separation for disaster recovery

- [Australian Cyber Security Centre (ACSC) Information Security Manual (ISM)](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)
- [Amazon Web Services (AWS) Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [National Institute of Standards and Technology (NIST) Cybersecurity Framework (CSF)](https://www.nist.gov/cyberframework)

## Decision

Implement standardized object storage backup solution with automated cross-region replication and lifecycle management for all critical systems and data.

**Storage Requirements:**

- Object storage with versioning and immutable storage capabilities
- Database, application data, and infrastructure configuration backups
- Encryption at rest and in transit per [ADR 005: Secrets Management](../security/005-secrets-management.md)
- Access controls aligned with [ADR 001: Application Isolation](../security/001-isolation.md)

**Geographic Distribution:**

- Cross-region replication within Australia
- Multi-cloud backup for critical systems
- Monitoring integration per [ADR 007: Centralised Security Logging](../operations/007-logging.md)

**Lifecycle Management:**

- Automated storage tiering based on age and access patterns
- Compliance-based retention policies
- Recovery testing and validation procedures

## Consequences

**Risks of not implementing:**

- Permanent data loss from single point of failure
- Extended recovery times during disasters
- Compliance violations from inadequate data retention
- Regional outages affecting backup availability
- Inability to meet business continuity requirements
- Legal and regulatory penalties from data loss incidents
