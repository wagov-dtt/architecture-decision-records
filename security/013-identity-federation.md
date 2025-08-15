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

## Decision

Standardize on OpenID Connect (OIDC) as the primary federation protocol
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

- Applications should integrate through managed identity platforms, not
  directly with identity providers
- Separate privileged and standard user domains for clear administrative
  access isolation
- Support multiple upstream identity providers per application
- Maintain audit trails distinguishing privileged from standard user
  activities per [ADR 007: Centralised Security Logging](../operations/007-logging.md)

**Identity Federation Flow:**

```d2
Users -> Identity Providers -> Managed Platform

Identity Providers: {
  OIDC: {style.fill: "#4caf50"}
  SAML: {style.fill: "#ff9800"}
  Legacy: {style.fill: "#757575"}
}

Managed Platform: {
  Token Validation
  Protocol Translation
  Audit Logging
}

# Domain Separation
Managed Platform -> Standard Apps: {
  style.stroke: "#1565c0"
  style.stroke-width: 3
}

Managed Platform -> Admin Apps: {
  style.stroke: "#c62828"
  style.stroke-width: 3
}

Standard Apps: {
  style: {
    fill: "#e3f2fd"
    stroke: "#1565c0"
  }
}

Admin Apps: {
  style: {
    fill: "#ffebee"
    stroke: "#c62828"
  }
}

Standard Apps -> User Data
Admin Apps -> System Data
Admin Apps -> User Data: admin access
```

**Emerging Standards:**

- Client applications can leverage emerging OIDC standards around
  verifiable credentials to simplify adoption of federated identity with
  jurisdiction providers

**Implementation Requirements:**

- Implement fallback authentication mechanisms for critical systems
- Choose identity platforms with high availability and data export capabilities
- Maintain audit trails following [ADR 007: Centralised Security Logging](../operations/007-logging.md)

## Consequences

**Benefits:**

- Consistent modern federation standard across all applications
- Better security through OIDC’s improved token handling and PKCE
  support
- Simplified integration with jurisdiction citizen identity services
- Clear separation of administrative and standard user access

**Risks if not implemented:**

- Fragmented authentication systems across applications
- Legacy SAML limitations hindering citizen service integration
- Inconsistent security posture across identity touchpoints


