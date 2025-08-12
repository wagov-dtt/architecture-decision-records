# ADR 003: API Documentation Standards

**Status:** Accepted | **Date:** 2025-03-26

## Context

Secure, maintainable APIs require mature frameworks with low complexity and industry standard compliance. Where existing standards exist, prefer them over bespoke REST APIs.

**Compliance Requirements:**
- [ACSC Software Development Guidelines](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development)
- [OWASP API Security](https://owasp.org/www-project-api-security/)
- [OpenAPI Specification](https://spec.openapis.org/)

## Decision

### API Requirements

| Requirement | Standard | Mandatory |
|-------------|----------|-----------|
| **Documentation** | [OpenAPI Specification](https://spec.openapis.org/) | Yes |
| **Testing** | [Restish CLI](https://rest.sh/#/openapi) scripts | Yes |
| **Framework** | [Huma](https://huma.rocks/) or [FastAPI](https://fastapi.tiangolo.com/) | Recommended |
| **Naming** | Consistent convention | Yes |
| **Security** | OWASP API security coverage | Yes |
| **Exposure** | No admin APIs on Internet | Yes |

### Development Guidelines

- **Self-Documenting**: Use frameworks that auto-generate OpenAPI specs
- **Data Types**: Prefer standard types over custom formats
- **Segregation**: Separate APIs by purpose
- **Testing**: Include security vulnerability checks in test scripts

**API Development Flow:**

```d2
direction: right

framework: "Self-Documenting\nFramework"
openapi: "OpenAPI\nSpecification" 
testing: "Automated\nTesting"

framework -> openapi -> testing
framework -> testing

openapi.note: "Auto-generated docs"
testing.note: "Security & behaviour checks"
```

## Consequences

**Without this approach**: Security vulnerabilities, documentation drift, poor quality APIs, and increased maintenance overhead.

**With this approach**: Secure, well-documented APIs with automated testing and reduced maintenance burden.
