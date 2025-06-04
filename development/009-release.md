---
title: Consistent release documentation
date: 2025-03-04
status: Accepted
tags:
- #code
- #infrastructure
- #security
- #change
---

## Status

Accepted

## Context

To ensure clear communication of changes and updates to security and infrastructure operations teams, release notes should be standardised. The release notes should succinctly capture key information, including new features, improvements, bug fixes, security updates, and infrastructure changes, with links to relevant changelogs.


- [ACSC Guidelines for Software Development](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development)


## Decision
Adopt a standardised release notes template in [Markdown](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) format. Brief descriptions should include the security implications and operational impacts of changes such as vulnerability fixes, compliance improvements, or changes to authentication and authorization mechanisms. Descriptions should also detail operational aspects, including deployment processes, logging & monitoring considerations, and any modifications to infrastructure as code (IaC).

A template is provided below that can be tailored per project. A completed release notes Markdown document should be provided with all proposed changes.

```markdown
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
- [Bug Fix/Security Update 1]: Brief description.
- [Bug Fix/Security Update 2]: Brief description.

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

**Risks of not implementing**:

- Miscommunication between teams.
- Loss of context leading to weakened decision making procedures.

**Positive Consequences**:

- Improved clarity and consistency in communicating release updates.
- Consistent tracking of changes and updates for security and infrastructure teams.
- Enhanced collaboration and understanding across teams.