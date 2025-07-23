---
title: "ADR 005: Secrets Management"
date: 2025-02-25
status: Accepted
tags:
- #security
- #architecture
- #secrets
---

## Status

Accepted

## Context

Per the [Open Web Application Security Project (OWASP) Secrets Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html):

> Organizations face a growing need to centralize the storage, provisioning, auditing, rotation and management of secrets to control access to secrets and prevent them from leaking and compromising the organization. Often, services share the same secrets, which makes identifying the source of compromise or leak challenging.

To address these challenges, we need a standardised, auditable approach to managing and rotating secrets within our environments. Secrets should be accessed at runtime by workloads and should never be hard-coded or stored in plain text.

- [Amazon Web Services (AWS) Secrets Manager Compliance validation](https://docs.aws.amazon.com/secretsmanager/latest/userguide/secretsmanager-compliance.html)
- [Using Elastic Kubernetes Service (EKS) encryption provider support for defense-in-depth](https://aws.amazon.com/blogs/containers/using-eks-encryption-provider-support-for-defense-in-depth/)

## Decision

Use [AWS Secrets Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html) to store and manage secrets.

- Secrets should be fetched and securely injected into AWS resources at runtime.
- The secret rotation period (lifetime) must be captured in the system design.
  - Rotate secrets automatically where possible, or ensure that a manual rotation process is documented and followed.
- [Use Identity and Access Management (IAM) policy statements](https://docs.aws.amazon.com/secretsmanager/latest/userguide/best-practices.html#w21aab9c19) to use least-privilege access to secrets.
- [ADR 002: AWS EKS for Cloud Workloads](../operations/002-workloads.md) kubernetes workloads should use [EKS Key Management Service (KMS) secrets encryption](https://docs.aws.amazon.com/eks/latest/userguide/enable-kms.html) with namespace local secrets by default.
  - If secrets need to be accessed by several clusters, use [External Secrets Operator](https://external-secrets.io/latest/) to synchronise them from the primary secret store in AWS Secrets Manager.

## Consequences

Positive:

- **Automated Management**: Reduces human error and ensures consistent updates.
- **Compliance**: Meets auditing and compliance requirements.

Negative:

- **Dependency on AWS**: Using AWS Secrets Manager for all secrets could make future migrations of AWS difficult. Ensuring secret rotation is straightforward and documented should minimise this consequence.

Risks of not implementing:

- **Security Risk**: Regular handling or manual handling of secrets increases exposure risk.
- **Operational Overhead**: Manual processes for configuring and rotating secrets can be error-prone and inefficient.

By implementing this decision, we aim to enhance the security and efficiency of our secret management processes, ensuring that sensitive information is handled securely and automatically.
