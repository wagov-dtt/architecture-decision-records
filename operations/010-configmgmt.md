---
title: Deploy Infrastructure As Code (IAC) and identify misconfiguration
date: 2025-03-10
status: Accepted
tags:
- #infrastructure
- #security
- #iac
---

## Status

Accepted

## Context

The goal is to ensure the security and integrity of infrastructure throughout the deployment lifecycle. Threat actors exploit vulnerabilities in infrastructure components, misconfigurations, exposed secrets, and deployment drift.

- [OWASP Infrastructure as Code Security Guidance](https://cheatsheetseries.owasp.org/cheatsheets/Infrastructure_as_Code_Security_Cheat_Sheet.html)
- [ACSC Guidelines for System Hardening](https://www.cyber.gov.au/resources-business-and-government/essential-cybersecurity/ism/cybersecurity-guidelines/guidelines-system-hardening)

## Decision

Infrastructure as Code (IaC) repositories should follow the below standard practices (or similar equivalents) before deploying tagged workloads (indicated as low risk by [development/004-cicd.md](../development/004-cicd.md)) to production environments:

- Use [Justfiles](https://just.systems/man/en/) to **manage operations tasks**.
- Use [kubectl & kustomize](https://kubectl.docs.kubernetes.io/guides/config_management/) or a [trivy supported IaC language](https://trivy.dev/latest/docs/coverage/iac/) (e.g. Terraform) for **config management and naming conventions**.
- Use [Trivy](https://trivy.dev/latest/docs/configuration/) to **identify misconfigurations and exposed secrets**.
- **Maintain isolation between workloads** as per [security/001-isolation.md](../security/001-isolation.md)
- **Encrypt and audit secrets** as per [security/005-secrets-management.md](../security/005-secrets-management.md)
- **Test releases against multiple accounts or targets** like [k3d](https://k3d.io/stable/) locally and [EKS](https://docs.aws.amazon.com/eks/latest/userguide/quickstart.html) on a hyperscaler as per [operations/002-workloads.md](../operations/002-workloads.md).

## Consequences

If we do not implement these practices, we risk:

- Deploying infrastructure with known vulnerabilities that can be exploited by attackers.
- Exposing sensitive information due to misconfigurations or hardcoded secrets.
- Compromising the integrity and reliability of our infrastructure due to inadequate testing.
- Non-compliance with legislated requirements, leading to potential legal and reputational risks.

By adopting the above baseline for our configuration management and infrastructure management, we ensure compliance with best practices, and maintain high-quality infrastructure delivery.
