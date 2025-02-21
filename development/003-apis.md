---
title: Use Huma REST/HTTP Framework for APIs
date: 2025-02-17
status: Proposed
tags:
- #api
- #golang
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

We propose using [Huma](https://huma.rocks/) for developing new APIs. Huma is a Golang-based framework that meets the following criteria:

1. **Maturity**: Golang is a mature language with a strong ecosystem, making it a reliable choice for API development.
2. **Standards Compliance**: Huma adheres to OpenAPI standards, ensuring that our APIs are well-documented and testable.
3. **Security**: The framework aligns with OWASP standards, providing a secure foundation for our APIs.
4. **Low Complexity**: Huma is designed to be low in complexity, making it easier to maintain and keep in sync with expected changes.

## Consequences

If we do not adopt a framework like Huma, we risk:

- **Security Vulnerabilities**: Using less mature programming languages or less guided frameworks could lead to unintended security vulnerabilities being introduced.
- **Poor Documentation**: Not using a framework with automated documentation generation can result in documentation and tests getting out of sync.
- **Increased Maintenance**: Higher complexity frameworks would increase the third party dependencies and the effort required to maintain and update our APIs.
