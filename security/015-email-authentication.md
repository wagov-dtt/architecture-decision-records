---
title: "ADR 015: Email Authentication Protocols"
date: 2025-07-22
status: Proposed
tags:
- #email
- #security
---

## Status

Proposed

## Context

Government domains are vulnerable to email spoofing, phishing, and brand impersonation attacks without proper email authentication protocols. Industry standards (SPF, DKIM, DMARC, BIMI) provide essential protection against these threats.

- [ACSC Information Security Manual (ISM)](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)

## Decision

Implement email authentication standards for all government domains:

**Required Standards:**

- **SPF**: Publish records defining authorized mail servers with strict policies ("~all" or "-all")
- **DKIM**: Sign all outbound email with minimum 2048-bit RSA keys, rotate annually
- **DMARC**: Progress from "p=none" to "p=reject" with subdomain policies and reporting
- **BIMI**: Implement verified brand logos with Verified Mark Certificates (VMCs)

**Implementation:**

- Monitor DNS records for tampering
- Regular authentication testing and effectiveness reviews
- Incident response procedures for authentication failures
- Integration with email security gateways

## Consequences

**Risks of not implementing:**

- Email spoofing and phishing attacks using government domains
- Brand reputation damage and reduced email deliverability
- Compliance violations with security requirements

**Benefits:**

- Significant reduction in email-based attacks
- Enhanced brand protection and email trust
- Improved compliance and threat visibility
