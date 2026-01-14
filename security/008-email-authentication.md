# ADR 008: Email Authentication Protocols

**Status:** Accepted | **Date:** 2025-08-15

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

- **SPF**: Publish records defining authorized mail servers. Use "-all"
  (hard fail) for domains with well-defined mail infrastructure; use
  "~all" (soft fail) only during initial rollout or when third-party
  senders are being onboarded.
- **DKIM**: Sign all outbound email with minimum 2048-bit RSA keys,
  rotate annually.
- **DMARC**: Implement with a progression timeline:
  1. Start with "p=none" to collect reports (2-4 weeks)
  2. Move to "p=quarantine" once legitimate sources are aligned (4-8
      weeks)
  3. Progress to "p=reject" when reports show minimal false positives
  - Include "rua=" for aggregate reports and "ruf=" for forensic reports
  - Apply same policy to subdomains with "sp=reject"
- **MTA-STS**: Publish MTA-STS policy to enforce TLS for inbound mail
  transport.

**Recommended:**

- **BIMI**: Implement verified brand logos with Verified Mark
  Certificates (VMCs) for high-profile citizen-facing domains.

**Implementation:**

- Monitor DNS records for tampering
- Regular authentication testing and effectiveness reviews
- Incident response procedures for authentication failures
- Integration with email security gateways

## Consequences

**Benefits:**

- Automated email authentication blocking domain spoofing
- Enhanced brand protection and citizen trust
- Comprehensive threat visibility through DMARC reporting

**Risks if not implemented:**

- Phishing attacks exploiting government domain reputation
- Reduced email deliverability affecting citizen communications
- Non-compliance with government security requirements
