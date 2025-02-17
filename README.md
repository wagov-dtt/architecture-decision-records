# Architecture Decision Records

Architecture records and current decision state to support infrastructure and platform operations for DGOV DTT Team.

## Structure

The repository will hold lightweight version controlled architecture decision records as below. On acceptance of a record a new tagged release should be made and this readme updated.

- [Security](/security/) - Common decisions to uphold security and design controls (ref: ACSC ISM, OWASP ASVS, MASVS & NIST CSF)
    - Proposed: [001-isolation.md](security/001-isolation.md) - Isolate Applications and Environments by Default
- [Operations](/operations/) - Common decisions to support how infrastructure workloads are released and operated (ref: CNCF Cloud native)
    - Proposed: [002-workloads.md](operations/002-workloads.md) - Adopt AWS EKS auto mode for public cloud workloads
- [Development](/development/) - Decisions to design, build and run software securely (ref: OWASP ASVS, MASVS)
    - Proposed: [003-apis.md](development/003-apis.md) - Use Huma for APIs

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