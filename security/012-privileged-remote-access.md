# ADR 012: Privileged Remote Access

**Status:** Proposed | **Date:** 2025-07-22

## Context

Traditional privileged access methods using jump boxes, bastion hosts,
and shared credentials create security risks through persistent network
connections and broad administrative access. Modern cloud-native
alternatives provide better security controls and audit capabilities for
administrative tasks.

- [ACSC Information Security Manual
  (ISM)](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)
- [WA SOC Cyber Network Management
  Guideline](https://soc.cyber.wa.gov.au/guidelines/network-management/)

## Decision

Replace traditional bastion hosts and jump boxes with cloud-native
privileged access solutions:

**Prohibited Methods:**

- Bastion hosts and jump boxes with persistent SSH access
- Direct SSH/RDP access to production systems
- Shared administrative credentials and keys
- VPN-based administrative access

**Required Access Methods:**

- **Server Access**: AWS Systems Manager Session Manager (replaces SSH
  to EC2)
- **Infrastructure Management**: AWS CLI with temporary credentials
  (replaces persistent VPN)  
- **Kubernetes Access**: kubectl with IAM authentication (replaces
  cluster SSH)
- **Infrastructure Deployment**: Terraform Cloud with audit trails
  (replaces manual deployment)

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
