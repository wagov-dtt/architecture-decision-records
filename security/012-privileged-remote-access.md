# ADR 012: Privileged Remote Access

**Status:** Accepted | **Date:** 2025-08-15

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

```d2
direction: right

admin: Administrator
ssm: Session Manager
systems: Target Systems

admin -> ssm: MFA + identity
ssm -> systems: temporary session
```

Session Manager provides MFA enforcement, session recording, and audit
trails without persistent network access.

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
- **Infrastructure Deployment**: Infrastructure as Code with audit
  trails per [ADR 010: Infrastructure as
  Code](../operations/010-configmgmt.md) (replaces manual deployment)

**Access Controls:**

- Multi-factor authentication for all access
- Time-limited sessions
- Identity-based access through cloud IAM
- Approval workflows for privileged access
- Session recording and audit logging per [ADR 007: Centralised Security Logging](../operations/007-logging.md)

**Implementation:**

- All sessions initiated through APIs only
- Short-lived credentials
- Real-time monitoring and alerting
- Integration with SIEM systems

## Consequences

**Benefits:**

- Zero-trust network access with session recording
- Enhanced audit capabilities through centralised logging
- Short-lived credential security reducing persistent threats

**Risks if not implemented:**

- Unauthorised lateral movement across network systems
- Prolonged security breaches from persistent access
- Non-compliance with government zero-trust requirements
