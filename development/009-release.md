# ADR 009: Release Standards

**Status:** Accepted | **Date:** 2025-03-04

## Context

Release notes should be standardised so security and infrastructure
operations teams can quickly understand what changed, why it changed,
and what action is required. Each release should provide a concise,
reliable record of new features, improvements, bug fixes, security
updates, infrastructure changes, and links to relevant changelogs.

Release standards also need a clear promotion model. Without one,
integrated code can reach `main` before a release has completed testing,
and release evidence can become detached from the state that was
actually deployed. The release process should therefore cover both
release documentation and release promotion.

**Compliance Requirements:**

- [Australian Cyber Security Centre (ACSC) Guidelines for Software
  Development](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development)
- [Atlassian Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)

## Decision

Use a standardised release notes template in
[Markdown](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)
format and a Gitflow-based release model to document and promote
releases.

**Release Content:**

- Each release should summarise new features, improvements, bug fixes,
  security updates, and infrastructure changes
- Release descriptions should include security implications and
  operational impacts such as deployment considerations, logging and
  monitoring impacts, and modifications to Infrastructure as Code (IaC)
- Release documentation should link to relevant changelogs, test
  results, security scans, and approval records

**Release Workflow:**

- Use `develop` as the integration branch for ongoing work
- Use `main` as the release branch and release history
- Do not merge ongoing integration work directly from `develop` to
  `main`
- Create `release/*` branches from `develop` when a release candidate is
  ready for stabilisation and final testing
- Create `hotfix/*` branches from `main` for urgent production fixes
- Merge to `main` only when a release or hotfix has completed required
  testing and approval
- Create fixed semantic version tags on `main` only after the release
  has passed testing

**Environment Boundaries:**

- Developers work in DEV and INT
- Operators collaborate with developers in INT during release
  validation, then promote to UAT and PROD
- DEV and INT may deploy approved branch refs directly
- UAT and PROD must deploy immutable tagged releases only
- Operators must promote the same tested tag from UAT to PROD without
  rebuilding, moving, or recreating the tag

**Release Evidence and Tag Rules:**

- Record test results, security scan links, and approval evidence on
  pull requests or GitHub Releases
- Update release notes and release evidence on pull requests or GitHub
  Releases without changing an existing tag
- Tags must remain immutable and must not be reused to represent a
  different tested state
- Tag annotations should reference the release documentation location

**Git Tagging Requirements:**

- Create an annotated git tag for each release following semantic
  versioning (`v1.0.0`, `v1.1.0`, etc.)
- Tags must be created from commits on `main` only
- Tags should be created after the release has passed testing and the
  corresponding release documentation is complete

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

## Consequences

**Benefits:**

- Standardised release communication improves cross-team coordination
- `main` reflects tested release history rather than day-to-day
  integration state
- UAT and PROD promotion is more reliable because it uses immutable
  release tags
- Change tracking supports [ADR 007: Centralised Security Logging](../operations/007-logging.md)
- Documentation and release handoff are clearer for both developers and
  operators

**Risks if not implemented:**

- Critical release information may be lost between teams
- Integration changes may be promoted before release validation is
  complete
- Decision making may suffer from incomplete release context
- Security or operational issues may be introduced through undocumented
  system changes