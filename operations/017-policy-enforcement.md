---
title: "ADR 017: Automated Policy Enforcement"
date: 2025-07-22
status: Proposed
tags:
- #infrastructure
- #governance
- #compliance
---

## Status

Proposed

## Context

Cloud infrastructure requires automated policy enforcement to prevent misconfigurations, non-compliant deployments, and unauthorized resource provisioning. Manual compliance checking is prone to human error and cannot scale effectively.

- [ACSC Information Security Manual (ISM)](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)

## Decision

Implement automated infrastructure policy guardrails across all cloud environments:

**Preventive Controls:**

- Service Control Policies (SCPs) preventing non-compliant resource creation
- IAM policies enforcing least-privilege access
- Resource tagging policies for governance and cost allocation
- Encryption-at-rest and in-transit enforcement

**Detective Controls:**

- AWS Config Rules or equivalent for compliance monitoring
- Real-time configuration drift detection
- Security group and public resource exposure monitoring
- Cost anomaly detection and alerting

**Key Policy Areas:**

- Mandatory encryption for all data stores
- Public access restrictions on storage buckets
- SSL/TLS enforcement for all communications
- Geographic restrictions for data sovereignty
- Backup and disaster recovery configuration validation

**Implementation:**

- IaC integration with policy validation
- CI/CD pipeline policy checks before deployment
- Real-time policy violation alerting
- Exception approval workflows for valid business needs
- Automated remediation for common violations

## Consequences

**Risks of not implementing:**

- Security misconfigurations leading to data breaches
- Compliance violations and regulatory penalties
- Uncontrolled cloud spending

**Benefits:**

- Proactive prevention of security misconfigurations
- Automated compliance with government requirements
- Consistent security policies across environments
