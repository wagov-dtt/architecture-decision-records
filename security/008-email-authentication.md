---
title: 'ADR 008: Email Authentication Protocols'
date: 2025-07-22T00:00:00.000Z
status: Proposed
tags:
  - email
  - security
---


**Status:** Proposed \| **Date:** 2025-07-22

## Context

Government email domains are prime targets for cybercriminals who
exploit them for phishing attacks, business email compromise, and brand
impersonation. Citizens and businesses expect government emails to be
trustworthy, making email authentication critical for maintaining public
confidence and preventing fraud.

Without proper email authentication, attackers can easily spoof
government domains to conduct social engineering attacks, distribute
malware, or harvest credentials from unsuspecting recipients.

References:

- [ACSC How to combat fake
  emails](https://www.cyber.gov.au/resources-business-and-government/maintaining-devices-and-systems/system-hardening-and-administration/email-hardening/how-combat-fake-emails)

## Decision

Implement email authentication standards for all government domains:

**Required Standards:**

- **SPF**: Publish records defining authorized mail servers with strict
  policies (“~all” or “-all”)
- **DKIM**: Sign all outbound email with minimum 2048-bit RSA keys,
  rotate annually
- **DMARC**: Progress from “p=none” to “p=reject” with subdomain
  policies and reporting
- **BIMI**: Implement verified brand logos with Verified Mark
  Certificates (VMCs)

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
