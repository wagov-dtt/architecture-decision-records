---
title: "ADR 001: Application Isolation"
date: 2025-02-17
status: Accepted
tags:
- #security
- #architecture
- #isolation
---

## Status

Accepted

## Context

Not isolating applications and environments can lead to significant security risks. The risk of lateral movement means threats of vulnerability exposure of a single application can compromise other applications or the entire environment. This lack of isolation can enable the spread of malware, unauthorised access, and data breaches.

- [Open Web Application Security Project (OWASP) Application Security Verification Standard (ASVS)](https://owasp.org/www-project-application-security-verification-standard/)
- [Australian Cyber Security Centre (ACSC) Guidelines for System Hardening](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-system-hardening)

## Decision

To mitigate the risks associated with shared environments, all applications and environments should isolate by default. This isolation can achieve through the following approaches:

1. **Dedicated Accounts**: Use separate cloud accounts / resource groups for different environments (for example, development, testing, production) to ensure complete isolation of resources and data.
2. **Kubernetes Clusters**: Deploy separate Kubernetes clusters for different applications or environments to isolate workloads and manage resources independently.
3. **Kubernetes Namespaces**: Within a Kubernetes cluster, use namespaces to logically separate different applications or environments, providing a level of isolation for network traffic, resource quotas, and access controls.

The preferred approach for isolation should drive by data sensitivity and product boundaries.

## Consequences

If applications and environments are not isolated by default, the following consequences may arise:

1. **Increased Risk of Compromise**: A vulnerability in one application can lead to the compromise of other applications or the entire environment.
2. **Difficulty in Incident Response**: Without isolation, it becomes challenging to contain and mitigate security incidents.
3. **Compliance Issues**: Failure to isolate environments may lead to non-compliance with regulatory requirements and industry standards.
4. **Data Breaches**: Sensitive data may expose or stolen due to unauthorised access from the lack of isolation.

By adopting this decision, we aim to enhance the security posture of our systems, reduce the risk of security incidents, and ensure compliance with relevant standards and regulations.
