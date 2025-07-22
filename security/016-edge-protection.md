---
title: "ADR 016: Edge Protection"
date: 2025-07-22
status: Proposed
tags:
- #security
- #cdn
- #waf
---

## Status

Proposed

## Context

Public-facing web applications require protection from DDoS attacks, application-layer threats, and malicious traffic. CDNs with integrated WAFs provide essential edge protection, filtering attacks before they reach origin servers.

- [ACSC Information Security Manual (ISM)](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)

## Decision

All public web applications and APIs must use CDN with integrated WAF protection:

**CDN Requirements:**
- Geographic distribution with SSL/TLS termination at edge
- Cache optimization and origin shielding
- IPv6 dual-stack support

**WAF Protection:**
- OWASP Top 10 protection rules enabled
- Layer 7 DDoS protection and rate limiting
- Geo-blocking and bot management
- Custom rules for application-specific threats

**DDoS Protection:**
- AWS Shield Advanced or equivalent
- Real-time attack monitoring and alerting
- 24/7 DDoS Response Team access

**Implementation:**
- WAF logs integrated with SIEM systems
- Fail-secure configuration (no fail-open)
- Regular penetration testing and rule tuning
- CI/CD integration for automated deployments

## Consequences

**Risks of not implementing:**
- Service disruption from DDoS attacks
- Exploitation of web application vulnerabilities
- Poor performance and user experience

**Benefits:**
- Significant reduction in successful attacks
- Improved application performance and availability
- Enhanced security posture at network edge
