# Architecture Decision Records

Architecture records and current decision state to support infrastructure and platform operations for DGOV DTT Team. Supporting training material is available at the
[DGOV Technical - DevSecOps Induction](https://soc.cyber.wa.gov.au/training/devsecops-induction/) (guided by the [WA Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy)).

## Structure

The repository will hold lightweight version controlled architecture decision records as below. On acceptance of a record a new tagged release should be made and this readme updated.

### [/security/](/security/) Decisions to uphold security and design controls

References: [ACSC ISM](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism), [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/), [MASVS](https://mas.owasp.org/MASVS/) & [NIST CSF](https://www.nist.gov/cyberframework)

- Proposed: [001-isolation.md](security/001-isolation.md) - Isolate Applications and Environments by Default

### [/operations/](/operations/) Decisions to support how infrastructure workloads are released and operated

References: [CNCF Cloud native landscape](https://landscape.cncf.io/)

- Proposed: [002-workloads.md](operations/002-workloads.md) - Adopt AWS EKS auto mode for public cloud workloads

### [/development/](/development/) Decisions to design, develop, build and test software securely

References: [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/), [MASVS](https://mas.owasp.org/MASVS/)

- Proposed: [003-apis.md](development/003-apis.md) - Use Huma for APIs
- Proposed: [004-cicd.md](development/004-cicd.md) - Implement CI/CD and QA to sign build artifacts (containers and software) before release

## Record Template

Each record (named `001-name.md`)should have the below content named like defining high level decisions:

```markdown
---
title: 1. Use Cloudfront for Ingress
date: 2024-09-13
status: Proposed|Accepted|Deprecated|Superseded
tags:
- #networks
- #infrastructure
- #aws
---

## Status

[Proposed, Accepted, Deprecated, Superseded]

## Context

What is the problem (Threat actors like attacking things on the internet)

- [Framework References]

## Decision

What should become standardised to avoid the problem (We should ensure all inbound traffic from internet is logged/monitored/controlled)

## Consequences

What will happen if we don't avoid the problem (Exposed systems will get compromised)
```