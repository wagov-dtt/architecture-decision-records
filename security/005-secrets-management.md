---
title: Use AWS Secrets Manager and secrets encryption on Kubernetes
date: 2025-02-25
status: Proposed
tags:
- #security
- #architecture
- #secrets
---

## Status

Proposed

## Context

We need a secure method to manage secrets for various environments thats easy to use and auditable. The core goals are to ensure secrets are never stored unencrypted or in version control, don't need to be accessed or copied for business as usual, can be rotated easily, and are accessible at runtime by workloads where needed.

- [OWASP Secrets Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html)
- [AWS Secrets Manager Compliance validation](https://docs.aws.amazon.com/secretsmanager/latest/userguide/secretsmanager-compliance.html)
- [Using EKS encryption provider support for defense-in-depth](https://aws.amazon.com/blogs/containers/using-eks-encryption-provider-support-for-defense-in-depth/)

## Decision

Use [AWS Secrets Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html) to store and manage secrets. Secrets should be fetched and injected into AWS Resources at runtime. [Kubernetes workloads](../operations/002-workloads.md) should use [EKS KMS secrets encryption](https://docs.aws.amazon.com/eks/latest/userguide/enable-kms.html) with cluster local secrets by default. If secrets need to be accessed by multiple clusters, use [External Secrets Operator](https://external-secrets.io/latest/) to synchronise them from a primary secret store in AWS Secrets Manager.

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
