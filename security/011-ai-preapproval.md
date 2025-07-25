---
title: "ADR 011: AI Tool Pre-Approval"
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

AI-powered development tools like GitHub Copilot and Amazon CodeWhisperer process source code, potentially exposing sensitive data and intellectual property to third-party services. These tools can introduce security vulnerabilities through AI-generated code and may violate data sovereignty requirements. Without formal governance, teams may unknowingly expose confidential information or introduce non-compliant code into production systems.

Current risks include:

- Source code and sensitive data transmitted to external AI services
- AI-generated code potentially containing security vulnerabilities or licensing issues  
- Inconsistent AI tool usage across development teams
- Potential violations of data residency and privacy regulations

- [Open Web Application Security Project (OWASP) Application Security Verification Standard (ASVS)](https://owasp.org/www-project-application-security-verification-standard/)
- [Western Australia (WA) Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy)

## Decision

Implement mandatory pre-approval for all AI-powered development tools through a formal security and compliance review process.

**Covered Tools:**

- Code generation and AI-assisted development tools
- AI-powered IDEs and extensions
- Automated code analysis and testing tools

**Approval Requirements:**

- Australian data sovereignty compliance
- Security and privacy assessment
- Integration review with existing workflows
- Regular usage review and tool validation

## Consequences

**Risks of not implementing:**

- **Data Sovereignty Violations**: Australian government code and data processed by offshore AI services
- **Security Vulnerabilities**: AI-generated code introducing SQL injection, XSS, or authentication bypasses
- **Intellectual Property Loss**: Proprietary algorithms and business logic exposed to third-party training models
- **Compliance Failures**: Violation of Privacy Act 1988 and government data classification requirements
- **Audit and Legal Issues**: Inability to demonstrate due diligence in security controls during incidents
- **Inconsistent Risk Management**: Teams using unapproved tools creating security gaps and policy violations

**Benefits of implementation:**

- Clear governance framework for AI tool adoption
- Reduced security risk through vetted tool usage
- Compliance with Australian data sovereignty requirements
- Standardized security controls across development teams
- Audit trail for AI tool usage and security assessments
