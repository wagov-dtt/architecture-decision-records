# Architecture Decision Records

Architecture records and current decision state to support infrastructure and platform operations for DGOV DTT Team. Supporting training material is available at the [DGOV Technical - DevSecOps Induction](https://soc.cyber.wa.gov.au/training/devsecops-induction/) (guided by the [WA Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy)). The [Architecture Principles](./architecture-principles.md) used to guide decisions are also in this repository for reference.

## Structure

The repository will hold lightweight version controlled architecture decision records as below. On acceptance of a record a new tagged release should be made and this readme updated.

### [/security/](/security/) Decisions to uphold security and design controls

References: [ACSC ISM](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism), [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/), [MASVS](https://mas.owasp.org/MASVS/) & [NIST CSF](https://www.nist.gov/cyberframework)

- Accepted: [001-isolation.md](security/001-isolation.md) - Isolate Applications and Environments by Default
- Accepted: [005-secrets-management.md](security/005-secrets-management.md) - Use AWS Secrets Manager and secrets encryption on Kubernetes.
- TODO: [006-infrastructure-constraints.md](security/006-infrastructure-constraints.md) - Ensure infrastructure constraints are centrally defined and enforced.

### [/operations/](/operations/) Decisions to support how infrastructure workloads are released and operated

References: [CNCF Cloud native landscape](https://landscape.cncf.io/)

- Accepted: [002-workloads.md](operations/002-workloads.md) - Adopt AWS EKS auto mode for public cloud workloads.
- Accepted: [007-logging.md](operations/007-logging.md) - Collect relevant security logs into [centralised SIEM tooling](https://soc.cyber.wa.gov.au/onboarding/sentinel-guidance/), and minimise logging of sensitive information.
- Accepted: [010-configmgmt.md](operations/010-configmgmt.md) - Deploy Infrastructure As Code (IAC) and identify misconfiguration.
- TODO: [008-email.md](operations/008-email.md) - Configure [BIMI](https://bimigroup.org) (including SPF/DKIM/DMARC) for all transactional and campaign based email.
- TODO: [013-config-state-consistency.md](operations/013-config-state-consistency.md) - Configuration management state consistency.
- TODO: [014-backup-object-storage.md](operations/014-backup-object-storage.md) - Backup strategy with object storage.

### [/development/](/development/) Decisions to design, develop, build and test software securely

References: [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/), [MASVS](https://mas.owasp.org/MASVS/)

- Accepted: [003-apis.md](development/003-apis.md) - Ensure APIs are documented and testable.
- Accepted: [004-cicd.md](development/004-cicd.md) - Enforce release quality with CI/CD prechecks and build attestation.
- Accepted: [009-release.md](development/009-release.md) - Consistent release documentation.
- TODO: [011-ai-usage-approval.md](development/011-ai-usage-approval.md) - AI usage pre-approval for development.
- TODO: [012-ai-sandboxing.md](development/012-ai-sandboxing.md) - AI sandboxing and access controls.

## Contributing

### Quick Start

1. **Setup**: Open in GitHub Codespaces or VS Code with devcontainer
2. **Find next number**: Run `just next-number`
3. **Create ADR**: Create new file in appropriate directory:
   - **development/** - Code, APIs, testing, CI/CD decisions
   - **operations/** - Infrastructure, deployments, monitoring
   - **security/** - Controls, compliance, isolation policies
4. **Use template**: Copy template below and fill in details ([Quick Reference](CONTRIBUTING.md))
5. **Validate**: Run `just validate` to check format and prose quality
6. **Preview**: Run `just serve` to preview website
7. **Update README**: Add your ADR to the appropriate section above

### ADR Format

We use the Architecture Decision Record (ADR) format, proposed by Michael Nygard in [this blog post](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions). Each ADR has:

-   **Title**: a description of the decision (not the problem)
-   **Status**: Proposed|Accepted|Deprecated|Superseded
-   **Context**: the facts behind the need to make the decision
-   **Decision**: what the team has decided to do
-   **Consequences**: both positive and negative consequences (start with 'risks of not implementing')

### Decision Record Template

Each record (named `015-short-name.md`) follows this pattern:

**Good titles:** "Adopt AWS EKS auto mode", "Enforce CI/CD prechecks", "Use secrets encryption"  
**Bad titles:** "Database issues", "Security problems", "Frontend changes"

```markdown
---
title: 15. Use API Gateway for External Access
date: 2025-01-22
status: Proposed
tags:
- #infrastructure
- #security
- #apis
---

## Status

Proposed

## Context

External clients need secure, monitored access to internal services. Direct service exposure creates security risks and lacks centralized logging/rate limiting.

- [OWASP API Security Top 10](https://owasp.org/www-project-api-security/)
- [AWS API Gateway Best Practices](https://docs.aws.amazon.com/apigateway/)

## Decision

All external API access must route through AWS API Gateway with:
- Authentication and authorization controls
- Rate limiting and throttling
- Request/response logging to CloudWatch
- WAF integration for threat protection

## Consequences

**Risks of not implementing:**
- Uncontrolled external access to internal services
- No centralized monitoring or rate limiting
- Difficulty implementing consistent security policies
- Compliance violations from inadequate access controls
```
