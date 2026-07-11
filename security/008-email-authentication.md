# ADR 008: Email Authentication Protocols

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

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
- [RFC 7208: SPF](https://www.rfc-editor.org/rfc/rfc7208)
- [RFC 6376: DKIM](https://www.rfc-editor.org/rfc/rfc6376)
- [RFC 7489: DMARC](https://www.rfc-editor.org/rfc/rfc7489)
- [RFC 8460: SMTP TLS Reporting](https://www.rfc-editor.org/rfc/rfc8460)
- [RFC 8461: MTA-STS](https://www.rfc-editor.org/rfc/rfc8461)

## Decision

Apply email authentication to every agency-controlled domain, including
active sending and receiving domains, non-sending domains, delegated
subdomains, and parked domains.

**Required Standards:**

- **SPF**: Authorise only known sending services and target `-all`. Use
  `~all` only during a measured transition with an owner and deadline.
- **DKIM**: Sign outbound mail using agency-approved algorithms, key sizes,
  and cryptoperiods. Document selector rollover, rotate before the approved
  cryptoperiod expires or after compromise, and remove superseded keys after
  delivery queues have cleared.
- **DMARC**: Start active sending domains at `p=none` with aggregate `rua`
  reporting. Progress through sampled or full quarantine to `p=reject` when
  measured reports show legitimate senders have aligned SPF or DKIM and
  false-positive risk is acceptable. Each domain must have an owned,
  risk-approved deadline for reject enforcement rather than a fixed generic
  interval. Set subdomain policy deliberately; do not assume every subdomain
  has the same sending pattern.
- **Forensic reports**: Enable `ruf` only after assessing personal,
  sensitive, cross-border disclosure, retention, and report-processor risks.
- **Non-sending domains**: Publish a null SPF record and DMARC `p=reject`
  for parked domains and domains that must not send email. Use null MX where
  the domain must not receive email.
- **Inbound protection**: Email gateways must evaluate SPF, DKIM, and DMARC,
  detect display-name and lookalike-domain impersonation, and quarantine or
  reject messages according to the assessed risk.
- **Mail transport**: For receiving domains, deploy MTA-STS in testing mode,
  validate delivery, then enforce it. Publish TLS-RPT to monitor TLS policy
  failures. An approved DANE design may provide equivalent protection.

**Recommended:**

- **BIMI**: Implement verified brand logos with Verified Mark
  Certificates (VMCs) for high-profile citizen-facing domains.

**Implementation:**

- Monitor DNS records for tampering
- Maintain an inventory of agency domains and authorised sending services
- Record the owner, sending and receiving status, DMARC enforcement
  deadline, DKIM cryptoperiod, and reporting destinations for each domain
- Regular authentication testing and effectiveness reviews
- Incident response procedures for authentication failures
- Integration with email security gateways

## Required Evidence

- Domain and authorised-sender inventory
- Current DNS records and independent SPF, DKIM, and DMARC test results
- DMARC reporting that demonstrates measured alignment and policy
  progression against the approved deadline
- MTA-STS and TLS-RPT records, reports, and enforcement status where used
- Alerts and incident records for spoofing or unauthorised DNS changes

## Exceptions

Any missed DMARC enforcement deadline must identify the affected domain and
sender, migration plan, compensating gateway controls, residual risk,
executive approval, expiry date, and reassessment date.

## Consequences

**Benefits:**

- Automated email authentication blocking domain spoofing
- Enhanced brand protection and citizen trust
- Comprehensive threat visibility through DMARC reporting

**Risks if not implemented:**

- Phishing attacks exploiting government domain reputation
- Reduced email deliverability affecting citizen communications
- Non-compliance with government security requirements
