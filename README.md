# Architecture Decision Records

Architecture records and current decision state to support DTT Operational Control Framework

## Structure

The repository will hold lightweight version controlled architecture decision records as below. On acceptance of a record a new tagged release should be made and this readme updated.

- [Security](/security/) - Common decisions to uphold security and design controls (ref: OWASP ASVS, MASVS & NIST CSF)
- [Operations](/operations/) - Common decisions to support how infrastructure workloads are released and operated (ref: CNCF Cloud native)
- [Language Specific](/language-specific/) - Decisions to design, build and run language specific codebases and workloads securely (ref: OWASP ASVS, MASVS)

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