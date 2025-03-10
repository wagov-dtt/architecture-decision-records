---
title: Deploy Infrastructure As Code (IAC) and identify misconfiguration
date: 2025-03-10
status: Proposed
tags:
- #infrastructure
- #security
- #iac
---

## Status

Proposed

## Context

The goal is to ensure the security and integrity of infrastructure throughout the deployment lifecycle. Threat actors exploit vulnerabilities in infrastructure configurations, misconfigurations, exposed secrets, and deployment drift.

- [OWASP Infrastructure as Code Security Guidance](https://cheatsheetseries.owasp.org/cheatsheets/Infrastructure_as_Code_Security_Cheat_Sheet.html)
- [ACSC Guidelines for System Hardening](https://www.cyber.gov.au/resources-business-and-government/essential-cybersecurity/ism/cybersecurity-guidelines/guidelines-system-hardening)

## Decision

Infrastructure as Code (IaC) repositories should follow the below standard practices (or similar equivalents) before deploying tagged workloads (indicated as low risk by [development/004-cicd.md](../development/004-cicd.md)) to production environments:

- Use [Justfiles](https://just.systems/man/en/) to **manage operations tasks**.
- Use [kubectl & kustomize](https://kubectl.docs.kubernetes.io/guides/config_management/) for **config management and naming conventions**.
- Use [Checkov](https://www.checkov.io/1.Welcome/What%20is%20Checkov.html) to **identify misconfigurations and exposed secrets**.
- Test releases against multiple orchestrators like [minikube](https://minikube.sigs.k8s.io/docs/handbook/) and [EKS](https://docs.aws.amazon.com/eks/latest/userguide/quickstart.html)

## Consequences

If we do not implement these practices, we risk:

- Deploying infrastructure with known vulnerabilities that can be exploited by attackers.
- Exposing sensitive information due to misconfigurations or hardcoded secrets.
- Compromising the integrity and reliability of our infrastructure due to inadequate testing.
- Non-compliance with legislated requirements, leading to potential legal and reputational risks.

By adopting the above baseline for our IaC approach, we ensure compliance with best practices, and maintain high-quality infrastructure delivery.
---