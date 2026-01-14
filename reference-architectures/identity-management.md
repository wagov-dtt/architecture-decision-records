# Reference Architecture: Identity Management

**Status:** Proposed | **Date:** 2025-07-29

## When to Use This Pattern

Use when building:

- Applications requiring user login via government or enterprise identity providers
- Single sign-on across multiple services
- Integration with Australian Government Digital ID or verifiable credentials

## Overview

This template implements OIDC-based identity federation using a broker pattern. A central identity broker translates between upstream providers (Government Digital ID, enterprise directories) and downstream applications (your services), providing a single integration point with centralised policy enforcement.

## Identity Federation Pattern

This pattern implements a **broker-based identity federation** that
translates between upstream identity providers (Government Digital ID,
verifiable credentials) and downstream identity consumers (AWS Cognito,
Microsoft Entra ID).

**Key Benefits:**

- Single integration point for multiple upstream providers
- Standardised OIDC/SAML interface for downstream consumers  
- Centralised policy enforcement and audit logging
- Support for both government and commercial identity ecosystems

## Core Components

```d2
direction: right

providers: Identity Providers
broker: Identity Broker
apps: Your Applications

providers -> broker: authenticate
broker -> apps: issue tokens
```

The architecture consists of three layers:

- **Identity Providers**: Government Digital ID, enterprise directories, verifiable credentials
- **Identity Broker**: Normalises claims, enforces policies, provides audit logging
- **Applications**: Consume standardised OIDC/SAML tokens via AWS Cognito or Entra ID

## Project Kickoff Steps

1. **Infrastructure Foundation** - Follow [ADR 001: Application
    Isolation](../security/001-isolation.md), [ADR 002: AWS EKS for
    Cloud Workloads](../operations/002-workloads.md), and [ADR 018:
    Database Patterns](../operations/018-database-patterns.md) for
    identity service deployment and data separation
2. **Security & Secrets** - Follow [ADR 005: Secrets
    Management](../security/005-secrets-management.md) for OIDC client
    secrets and [ADR 007: Centralised Security
    Logging](../operations/007-logging.md) for authentication audit
    trails
3. **Identity Federation** - Follow [ADR 013: Identity Federation
    Standards](../security/013-identity-federation.md) for upstream
    provider integration and downstream consumer configuration
4. **Privileged Administration** - Follow [ADR 012: Privileged Remote
    Access](../security/012-privileged-remote-access.md) for identity
    service administration access

## Implementation Considerations

**Privacy & PII Protection (Digital ID Act 2024):**

- **Data minimisation**: Prohibit collection beyond identity
  verification requirements
- **No single identifiers**: Prevent tracking across services using
  persistent identifiers
- **Marketing restrictions**: Prohibit disclosure of identity
  information for marketing purposes
- **Voluntary participation**: Users cannot be required to create
  Digital ID for service access
- **Biometric safeguards**: Restrict collection, use, and disclosure of
  biometric information
- **Breach notification**: Implement cyber security and fraud incident
  management processes

**Identity Proofing Level Selection:**

- **IP1-IP2**: Low-risk transactions with minimal personal information
  exposure
- **IP2+**: Higher-risk services requiring biometric verification and
  stronger assurance
- **Risk assessment**: Match proofing level to transaction risk and data
  sensitivity
- **Credential binding**: Ensure authentication levels align with
  proofing requirements

**Standards Compliance:**

- Verifiable credentials: [ISO/IEC
  18013-5:2021](https://www.iso.org/standard/69084.html) and [W3C
  Verifiable Credentials](https://www.w3.org/TR/vc-data-model/)
- Government Digital ID: [Digital ID Act
  2024](https://www.digitalidsystem.gov.au/what-is-digital-id/digital-id-act-2024)
  privacy and security requirements
- International interoperability: [eIDAS
  Regulation](https://digital-strategy.ec.europa.eu/en/policies/eidas-regulation)
  patterns
