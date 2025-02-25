# Architecture Decision Records

Architecture records and current decision state to support infrastructure and platform operations for DGOV DTT Team. Supporting training material is available at the
[DGOV Technical - DevSecOps Induction](https://soc.cyber.wa.gov.au/training/devsecops-induction/) (guided by the [WA Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy)).



## Structure

The repository will hold lightweight version controlled architecture decision records as below. On acceptance of a record a new tagged release should be made and this readme updated.

### [/security/](/security/) Decisions to uphold security and design controls

References: [ACSC ISM](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism), [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/), [MASVS](https://mas.owasp.org/MASVS/) & [NIST CSF](https://www.nist.gov/cyberframework)

- Proposed: [001-isolation.md](security/001-isolation.md) - Isolate Applications and Environments by Default
- Proposed: [005-secrets-management.md](security/005-secrets-management.md) - Use AWS Secrets Manager and secrets encryption on Kubernetes.
- TODO: [006-infrastructure-constraints.md](security/006-infrastructure-constraints.md) - Ensure infrastructure constraints are centrally defined and enforced.

### [/operations/](/operations/) Decisions to support how infrastructure workloads are released and operated

References: [CNCF Cloud native landscape](https://landscape.cncf.io/)

- Proposed: [002-workloads.md](operations/002-workloads.md) - Adopt AWS EKS auto mode for public cloud workloads.
- Proposed: [007-logging.md](operations/007-logging.md) - Collect relevant security logs into [centralised SIEM tooling](https://soc.cyber.wa.gov.au/onboarding/sentinel-guidance/), and minimise logging of sensitive information.
- TODO: [008-email.md](operations/008-email.md) - Configure [BIMI](https://bimigroup.org) (including SPF/DKIM/DMARC) for all transactional and campaign based email.

### [/development/](/development/) Decisions to design, develop, build and test software securely

References: [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/), [MASVS](https://mas.owasp.org/MASVS/)

- Proposed: [003-apis.md](development/003-apis.md) - Use Huma REST/HTTP Framework for APIs.
- Proposed: [004-cicd.md](development/004-cicd.md) - Enforce release quality with CI/CD prechecks and build attestation.

## How to document decisions

Architecture decisions should be stored in version control so there is a record of what was changed, who by, and when. Decisions that affect a specific application should be in that application's code repository. Larger-scale decisions will reside in this central documentation repository.

We are using the Architecture Decision Record (ADR) format, proposed by Michael Nygard in [a blog post](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions) and since adopted widely. It consists of the following sections:

-   **Title**: a description of the decision (not the problem)
-   **Status**: Proposed|Accepted|Deprecated|Superseded
-   **Context**: the facts behind the need to make the decision
-   **Decision**: what the team has decided to do
-   **Consequences**: both positive and negative consequences of the decision (start with 'risks of not implementing')

Amazon Web Services (AWS) also provide [useful advice](https://docs.aws.amazon.com/prescriptive-guidance/latest/architectural-decision-records/welcome.html) about how and why the ADR process should be adopted.

### Decision Record Template

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