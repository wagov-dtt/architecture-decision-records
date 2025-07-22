---
title: "ADR 014: Use object storage for backups"
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

Critical data and system backups require reliable, scalable, and geographically distributed storage solutions. Object storage provides durability, versioning, and cross-region replication capabilities essential for disaster recovery and business continuity. Without standardized backup procedures to object storage, organizations risk data loss and extended recovery times.

- [Australian Cyber Security Centre (ACSC) Information Security Manual (ISM)](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)
- [Amazon Web Services (AWS) Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [National Institute of Standards and Technology (NIST) Cybersecurity Framework (CSF)](https://www.nist.gov/cyberframework)

## Decision

All critical data and system backups must store in object storage with cross-region and cross-cloud replication capabilities:

**Backup Requirements:**
- All databases, application data, and configuration backups stored in object storage
- Immutable backup storage with versioning and retention policies
- Encrypted backups both in transit and at rest
- Regular backup validation and recovery testing

**Cross-Region Replication:**
- Primary backups replicated to secondary region within same cloud provider
- Critical backups replicated to different cloud provider for additional resilience
- Automated replication monitoring and failure detection
- Geographic separation to protect against regional disasters

**Retention and Lifecycle:**
- Tiered storage lifecycle policies (hot, warm, cold, archive)
- Compliance-driven retention periods (3-7 years basic)
- Automated deletion of expired backups
- Legal hold capabilities for audit requirements

**Recovery Procedures:**
- Documented Recovery Time Objective (RTO) and Recovery Point Objective (RPO)
- Automated recovery testing procedures
- Cross-cloud recovery capabilities
- Regular disaster recovery exercises

## Consequences

**Risks of not implementing:**
- Permanent data loss from single point of failure
- Extended recovery times during disasters
- Compliance violations from inadequate data retention
- Regional outages affecting backup availability
- Inability to meet business continuity requirements
- Legal and regulatory penalties from data loss incidents
