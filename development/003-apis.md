---
title: Ensure APIs are documented and testable
date: 2025-02-17
status: Proposed
tags:
- #api
- #openapi
- #owasp
---

## Status

Proposed

## Context

A secure, and maintainable API framework is key for backends and new capabilities. We need to ensure that our APIs are built using mature technologies that adhere to industry standards such as the ACSC ISM, OpenAPI and OWASP. Additionally, the framework should be low in complexity to reduce maintenance overheads and implementation burdens.

- [ACSC ISM Guidelines for Software Development](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development)
- [OWASP API Security](https://owasp.org/www-project-api-security/)
- [OpenAPI Specification](https://spec.openapis.org/)

## Decision

Ensure all APIs have [Restish](https://rest.sh/#/openapi) test scripts. Develop new APIs with self-documenting frameworks such as [Huma](https://huma.rocks/) or [FastAPI](https://fastapi.tiangolo.com/) that meet the following criteria:

1. **Maturity**: Golang & Python are mature languages with strong ecosystems, making them reliable choices for API development.
2. **Standards Compliance**: Adhere to the OpenAPI standards, ensuring that our APIs are well-documented and testable.
3. **Security**: The frameworks align with OWASP standards, providing a secure foundation for our APIs.
4. **Low Complexity**: Self-documenting frameworks are low in complexity, making it easier to maintain and keep in sync with expected changes.

## Consequences

If we do not develop and test APIs using the above standards we risk:

- **Security Vulnerabilities**: Using less mature programming languages or less guided frameworks could lead to unintended security vulnerabilities being introduced.
- **Poor Quality**: Any manually updated specifications or test scripts can drift from the primary codebase resulting in issues and system faults.
- **Poor Documentation**: Not using a framework with automated documentation generation can result in documentation and tests getting out of sync.
- **Increased Maintenance**: Higher complexity frameworks would increase the third party dependencies and the effort required to maintain and update our APIs.
