---
title: "ADR 009: Release Standards"
description: "Standardise release notes so security, infrastructure, and operations teams can quickly understand changes and required actions."
url: "/development/009-release.html"
aliases:
  - "/docs/development/009-release/"
  - "/development/009-release/"
weight: 90
toc: true
---

## ADR 009: Release Standards

**Status:** Accepted | **Date:** 2025-03-04

### Context

Release notes should be standardised so security and infrastructure
operations teams can quickly understand what changed, why it changed,
and what action is required.

Release standards also need a clear promotion model. Without one,
integrated code can reach `main` before testing is complete, and release
evidence can become detached from the deployed version.

**Compliance Requirements:**

- [Australian Cyber Security Centre (ACSC) Guidelines for Software
  Development](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development)
- [Atlassian Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)

### Decision

Use Markdown release notes and a Gitflow-based release model.

**Release notes must include:**

- Summary of features, fixes, security updates, and infrastructure
  changes
- Security and operational impacts, including deployment, logging,
  monitoring, and Infrastructure as Code (IaC) changes
- Links to changelogs, test results, security scans, and approvals

**Release workflow:**

- `develop` is the integration branch
- `main` is the tested release history
- Create `release/*` branches from `develop` for release candidates
- Create `hotfix/*` branches from `main` for urgent production fixes
- Merge to `main` only after required testing and approval
- Tag releases on `main` using annotated semantic version tags such as
  `v1.0.0`

**Environment promotion:**

- DEV and INT may deploy approved branch refs
- UAT and PROD must deploy immutable tagged releases only
- Promote the same tested tag from UAT to PROD without rebuilding,
  moving, or recreating the tag
- Record evidence on pull requests or GitHub Releases; update evidence
  without changing existing tags

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
- **Response Timelines**: Critical (24h), High (7d), Medium (30d), Low (90d)

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

### Consequences

**Benefits:**

- Release communication is consistent across teams
- `main` reflects tested release history, not day-to-day integration
- UAT and PROD promotion uses immutable release tags
- Change tracking supports [ADR 007: Centralised Security Logging](/operations/007-logging.html)

**Risks if not implemented:**

- Critical release information may be lost between teams
- Integration changes may be promoted before release validation is
  complete
- Security or operational issues may be introduced through undocumented
  system changes
