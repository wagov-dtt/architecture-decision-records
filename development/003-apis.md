# ADR 003: API Documentation Standards

**Status:** Accepted | **Date:** 2025-03-26

## Context

A secure and maintainable Application Programming Interface (API)
framework is key for backends and new capabilities. We need to ensure
that our APIs use mature technologies that adhere to industry standards.
These include the Australian Cyber Security Centre (ACSC) Information
Security Manual (ISM), OpenAPI and Open Web Application Security Project
(OWASP). The framework should be low in complexity to reduce maintenance
overheads and use burdens. Where an existing mature industry standard
exists, that interface may be more suitable than a bespoke
Representational State Transfer (REST) API as described here.

- [ACSC ISM Guidelines for Software
  Development](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development)
- [OWASP API Security](https://owasp.org/www-project-api-security/)
- [OpenAPI Specification](https://spec.openapis.org/)

## Decision

Ensure all APIs have OpenAPI documentation and
[Restish](https://rest.sh/#/openapi) test scripts validating security
and behaviour. New APIs should be developed with self-documenting
frameworks such as [Huma](https://huma.rocks/) or
[FastAPI](https://fastapi.tiangolo.com/).

### API requirements

- **Naming Convention**: APIs **must** use a consistent naming
  convention.
- **Documentation**: APIs **must** be documented via the [OpenAPI
  specification](https://spec.openapis.org/). APIs **should** have
  test-cases developed for quality assurance and annotations documented
  for better clarity.
- **Automated Testing**: APIs **must** include automated test scripts
  (preferably based on [Restish CLI](https://rest.sh/)) with coverage
  for basic required behaviour and common API security flaws (refer
  [OWASP API Security](https://owasp.org/www-project-api-security/)).
- **Exposure Control**: Ensure administration/management APIs are not
  exposed to the Internet.
- **Frameworks:** New APIs **should** be developed with self-documenting
  frameworks such as Huma or FastAPI.
- **Data Types**: APIs **should** use standard data types and formats
  where possible, avoiding custom data types.
- **API Segregation**: APIs **should** segregate by purpose.

## Consequences

If we do not develop and test APIs using the above standards we risk:

- **Security Vulnerabilities**: Using less mature programming languages
  or less guided frameworks could lead to unintended security
  vulnerabilities being introduced.
- **Poor Quality**: Any manually updated specifications or test scripts
  can drift from the primary codebase resulting in issues and system
  faults.
- **Poor Documentation**: Not using a framework with automated
  documentation generation can result in documentation and tests getting
  out of sync.
- **Increased Maintenance**: Higher complexity frameworks would increase
  the third party dependencies and the effort required to maintain and
  update our APIs.
