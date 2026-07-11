# ADR 009: Release Standards

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

## Context

Release notes should be standardised so security and infrastructure
operations teams can quickly understand what changed, why it changed,
and what action is required.

Release standards also need a clear promotion model. Without one, integrated code
can be released before testing is complete, rebuilt differently between
environments, or detached from its release evidence.

**Compliance Requirements:**

- [Australian Cyber Security Centre (ACSC) Guidelines for Software
  Development](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development)

## Decision

Use Markdown release notes, protected source-control workflows, and immutable
artifact promotion.

### Applicability

This ADR applies to deployable software and packaged artifacts produced by the
agency. Release-note depth and approval should be proportionate to operational and
consumer impact. Documentation-only changes and unreleased prototypes may use a
lighter process defined by the repository owner.

It does not mandate a repository host, release cadence, branching model, or semantic
versioning. It also does not replace agency change-management or emergency-response
procedures.

**Release notes must include:**

- Summary of features, fixes, security updates, and infrastructure
  changes
- Security and operational impacts, including deployment, logging,
  monitoring, and Infrastructure as Code (IaC) changes
- Links to changelogs, test results, security scans, and approvals

### Protected Release Workflow

Teams may use protected Gitflow, GitHub Flow, or trunk-based development when the
chosen strategy provides:

- Protected release branches or refs with reviewed changes and required checks
- Traceability from source revision to build, approvals, artifact digest, and
  deployment
- An expedited, controlled path for urgent fixes without bypassing required
  evidence
- Least-privilege release rights and separation of production approval where
  required by risk or agency policy

[Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow),
[GitHub Flow](https://docs.github.com/en/get-started/using-github/github-flow), and
[trunk-based development](https://cloud.google.com/architecture/devops/devops-tech-trunk-based-development)
are examples, not additional requirements.

Use a documented, immutable release identifier. Use
[Semantic Versioning](https://semver.org/) where major, minor, and patch changes
communicate meaningful compatibility to consumers, such as for libraries or
versioned APIs. Other services may use a documented date, build, or release-number
scheme.

**Environment promotion:**

- DEV and integration environments may deploy approved source revisions or release
  candidates.
- UAT and production must deploy an approved immutable artifact identified by its
  cryptographic digest, not by a mutable tag alone.
- Promote the same tested artifact digest from UAT to production without rebuilding.
- Keep the release identifier, source revision, artifact digest, evidence, and
  deployment record linked. Evidence may be recorded in the repository, release
  service, or agency change system without altering the released artifact.
- Use the expedited release path for security remediations within the applicable
  agency or ACSC patching timeframe; record the vulnerability, severity,
  decision date, deployment time, and affected versions
- Do not treat the release-note template as a substitute for the current policy
  timeframe or a risk-based vulnerability decision

A template is provided below that can be tailored per project. A
completed release notes Markdown document should be provided with all
proposed changes.

``` markdown
## Release Notes

### Overview

- **Name:** Name
- **Version:** [Version Number](#)
- **Previous Version:** [Version Number](#)

### Changes and Testing

High level summary

**New Features & Improvements**:

- [Feature/Improvement 1]: Brief description including testing.
- [Feature/Improvement 2]: Brief description including testing.

**Bug Fixes & Security Updates**:

- [Bug Fix/Security Update 1]: Brief description with severity level and response timeline.
- [Bug Fix/Security Update 2]: Brief description with severity level and response timeline.
- **Required Timeline**: [Applicable policy or approved risk deadline]

### Changelogs

*Only include list items changed by this release*

- **Code**: Brief description. [View Changes](#)
- **Infrastructure**: Brief description. [View Changes](#)
- **Configuration & Secrets**: Brief description.

### Known Issues

- [Known Issue 1]: Brief description.
- [Known Issue 2]: Brief description.

### Action Required

- [Action 1]: Brief description of any action required by users or stakeholders.
- [Action 2]: Brief description of any action required by users or stakeholders.

### Contact

For any questions or issues, please contact [Contact Information].
```

## Required Evidence

- Immutable release identifier, artifact digest, source revision, approvals, test
  and scan results
- Release notes identifying security fixes and affected versions
- UAT-to-production promotion record demonstrating no rebuild
- Linked risk acceptance for deferred remediation

## Exceptions

Deferred security releases require compensating controls, residual risk,
accountable executive approval, expiry date, and a scheduled remediation release.
Where a legacy platform cannot promote the same artifact without rebuilding, record
the technical constraint, compare resulting artifacts, retain both digests, and
maintain a time-bound migration plan approved by the service owner.

### Legacy Adoption

Existing services should first protect their release refs, link deployments to
source revisions, and record artifact digests. Then remove environment-specific
rebuilds and improve release notes and approvals through a prioritised migration
plan. A branching-model migration is not required where the current protected
workflow satisfies this ADR.

## Consequences

**Benefits:**

- Release communication is consistent across teams
- Teams can retain a branching strategy suited to their delivery context
- UAT and production promotion uses immutable artifact digests
- Change tracking supports [ADR 007: Centralised Security Logging](../operations/007-logging.md)

**Risks if not implemented:**

- Critical release information may be lost between teams
- Integration changes may be promoted before release validation is
  complete
- Security or operational issues may be introduced through undocumented
  system changes
