---
title: "ADR 018: Zero Trust Remote Access"
date: 2025-07-22
status: Proposed
tags:
- #security
- #remote-access
- #zero-trust
---

## Status

Proposed

## Context

Traditional remote access methods (SSH, RDP, VPN) create security risks through persistent network connections, shared credentials, and broad network access. These approaches conflict with zero-trust principles and enable lateral movement attacks.

- [ACSC Information Security Manual (ISM)](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)

## Decision

Prohibit direct network-based remote access and mandate API-based remote administration:

**Prohibited Methods:**

- Direct SSH/RDP access to production systems
- VPN access for administrative purposes
- Jump boxes with persistent connections
- Shared administrative credentials

**Required API-based Access:**

- AWS Systems Manager Session Manager or equivalent
- Cloud-native solutions (Azure Bastion, GCP IAP)
- API-controlled temporary access tokens
- Just-in-time (JIT) access provisioning

**Access Controls:**

- Multi-factor authentication for all access
- Time-limited sessions (maximum 4 hours)
- Identity-based access through cloud IAM
- Approval workflows for privileged access
- Session recording and audit logging

**Implementation:**

- All sessions initiated through APIs only
- Short-lived credentials (maximum 1-hour validity)
- Real-time monitoring and alerting
- Integration with SIEM systems
- Emergency break-glass procedures with full audit

## Consequences

**Risks of not implementing:**

- Unauthorized lateral movement through network connections
- Persistent access leading to prolonged breaches
- Non-compliance with zero-trust principles

**Benefits:**

- Significantly reduced attack surface
- Enhanced audit capabilities and compliance
- Better credential security through short-lived tokens
