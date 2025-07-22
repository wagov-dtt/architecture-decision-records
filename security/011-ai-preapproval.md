---
title: "ADR 011: Require pre-approval for Artificial Intelligence (AI) tools"
date: 2025-07-22
status: Proposed
tags:
- #development
- #ai
- #security
- #governance
---

## Status

Proposed

## Context

AI tools and services integrate into development workflows. Without proper oversight, these tools can introduce security risks, compliance issues, and data exposure concerns. Organizations need clear governance around AI usage to maintain security posture while enabling productive development.

- [Open Web Application Security Project (OWASP) Application Security Verification Standard (ASVS)](https://owasp.org/www-project-application-security-verification-standard/)
- [Western Australia (WA) Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy)

## Decision

All use of AI tools and services in development workflows must be pre-approved through a formal review process. This includes but is not limited to:

- Code generation tools (GitHub Copilot, Amazon CodeWhisperer, etc.)
- AI-powered IDEs and extensions
- Automated testing and analysis tools
- Documentation generation services
- Code review and suggestion tools

Approval process must assess:
- Data privacy and residency requirements
- Security implications and access controls
- Compliance with organizational policies
- Integration with existing development workflows

## Consequences

**Risks of not implementing:**
- Unauthorized data exposure to third-party AI services
- Compliance violations with data protection regulations
- Introduction of vulnerable or malicious code
- Loss of intellectual property or sensitive information
- Inconsistent security standards across development teams
