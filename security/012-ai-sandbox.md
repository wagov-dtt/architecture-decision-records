---
title: "ADR 012: Sandbox Artificial Intelligence (AI) tools with access controls"
date: 2025-07-22
status: Proposed
tags:
- #development
- #ai
- #security
- #isolation
---

## Status

Proposed

## Context

AI tools require strict isolation to prevent unauthorized access to sensitive systems, credentials, and data. Without proper sandboxing, AI services could inadvertently expose secrets, access privileged systems, or leak sensitive information through their training processes.

- [Australian Cyber Security Centre (ACSC) Information Security Manual (ISM)](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)
- [Open Web Application Security Project (OWASP) Application Security Verification Standard (ASVS)](https://owasp.org/www-project-application-security-verification-standard/)
- [Western Australia (WA) Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy)

## Decision

Any approved AI tools must be fully sandboxed with no access to:
- Production credentials or secrets
- Privileged system accounts
- Sensitive data repositories
- Network-privileged environments
- Administrative interfaces

Requirements:
- AI tools must run in isolated environments with minimal permissions
- No network access to internal systems or databases
- Separate service accounts with restricted access scopes
- Regular audit of AI tool permissions and data access
- Clear data classification and handling procedures
- Automated detection of credential or sensitive data exposure

## Consequences

**Risks of not implementing:**
- Credential exposure through AI tool data ingestion
- Unauthorized access to production systems
- Data breaches through AI service vulnerabilities
- Compliance violations with data protection standards
- Loss of sensitive intellectual property or customer data
- Privilege escalation through compromised AI tools
