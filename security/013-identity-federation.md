# ADR 013: Identity Federation Standards

**Status:** Accepted | **Date:** 2025-08-15

## Context

Applications need to integrate with multiple identity providers
including jurisdiction citizen identity services, enterprise
directories, and cloud identity platforms. Current approaches use
inconsistent protocols (SAML, OIDC, proprietary) creating integration
complexity and security inconsistencies.

Modern identity federation requires support for emerging standards like
verifiable credentials while maintaining compatibility with legacy
enterprise systems.

- [Digital ID Act 2024](https://www.legislation.gov.au/Details/C2024A00069)
- [OpenID Connect Core 1.0](https://openid.net/specs/openid-connect-core-1_0.html)
- [OWASP Authentication Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html)
- [EU Digital Identity Wallet Architecture and Reference Framework
  (ARF)](https://eudi.dev/) - European digital wallet standards
- [ISO/IEC 18013-5:2021 Mobile Driving
  Licence](https://www.iso.org/standard/69084.html) - mobile document
  (mDL) standard for verifiable credentials

## Decision

Standardise on OpenID Connect (OIDC) as the primary federation protocol
for all new identity integrations, with SAML 2.0 support only for legacy
systems that cannot support OIDC.

**Protocol Standards:**

- **Primary**: OpenID Connect for modern identity providers and new
  integrations
- **Legacy Support**: SAML 2.0 only when upstream providers require it
  and OIDC is unavailable
- **Security**: Implement PKCE for OIDC public clients and proper token
  validation
- **Compliance**: Support Digital ID Act 2024 requirements for
  jurisdiction identity services

**Architecture Requirements:**

- Applications should integrate through managed identity platforms (AWS
  Cognito, Microsoft Entra ID), not directly with identity providers
- Separate privileged and standard user domains for administrative
  access isolation (see [Reference Architecture: OpenAPI
  Backend](../reference-architectures/openapi-backends.md))
- Support multiple upstream identity providers per application
- Maintain audit trails per [ADR 007: Centralised Security
  Logging](../operations/007-logging.md)

**Identity Federation Flow:**

```d2
direction: down

standard: Standard User Domain {
  users: Users
  idp: Identity Providers
}

privileged: Privileged User Domain {
  admins: Administrators
  pim: Privileged Identity Management
}

platform: Managed Platform

standard.users -> standard.idp: authenticate
standard.idp -> platform: OIDC/SAML tokens
privileged.admins -> privileged.pim: authenticate
privileged.pim -> platform: elevated claims
platform -> apps: validated claims

apps: Applications
```

The managed platform handles protocol translation between OIDC and SAML
providers, token validation, and audit logging.

**Emerging Standards:**

- Support [W3C Verifiable Credentials](https://www.w3.org/TR/vc-data-model/)
  for jurisdiction identity services as they mature
- Plan for [OpenID4VC](https://openid.net/openid4vc/) wallet-based
  authentication patterns
- Align with [EU Digital Identity Wallet
  (EUDI)](https://eudi.dev/) architecture for international
  interoperability
- Support [ISO/IEC 18013-5](https://www.iso.org/standard/69084.html)
  mobile document (mDL) credentials for government-issued identity

**Implementation Requirements:**

- Implement fallback authentication mechanisms for critical systems
- Choose identity platforms with high availability and data export
  capabilities

## Consequences

**Benefits:**

- Consistent modern federation standard across all applications
- Better security through OIDC's improved token handling and PKCE
  support
- Simplified integration with jurisdiction citizen identity services
- Clear separation of administrative and standard user access

**Risks if not implemented:**

- Fragmented authentication systems across applications
- Legacy SAML limitations hindering citizen service integration
- Inconsistent security posture across identity touchpoints
