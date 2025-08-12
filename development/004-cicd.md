# ADR 004: CI/CD Quality Assurance

**Status:** Accepted | **Date:** 2025-03-10

## Context

Ensure security and integrity of software artifacts that are consumed by infrastructure repositories per [ADR 010](../operations/010-configmgmt.md). Threat actors exploit vulnerabilities in code, dependencies, container images, and exposed secrets.

**Compliance Requirements:**
- [OWASP CI/CD Security](https://cheatsheetseries.owasp.org/cheatsheets/CI_CD_Security_Cheat_Sheet.html)
- [ACSC Software Development Guidelines](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development)

## Decision

### CI/CD Pipeline Requirements

**Pipeline Flow**: Code Commit → Build & Test → Quality Assurance → Release

| Stage | Tools | Purpose | Mandatory |
|-------|-------|---------|-----------|
| **Build** | [Docker Bake](https://docs.docker.com/build/bake/) | Multi-platform builds with SBOM/provenance | Yes |
| **Scan** | [Trivy](https://trivy.dev/latest/docs/target/container_image/) | Vulnerability scanning | Yes |
| **Analysis** | [Semgrep](https://semgrep.dev/docs/getting-started/quickstart) | Static code analysis | Yes |
| **Test** | [Playwright](https://playwright.dev/docs/intro) | End-to-end testing | Recommended |
| **Performance** | [Grafana K6](https://grafana.com/docs/k6/latest/get-started/write-your-first-test/) | Load testing | Optional |
| **API** | [Restish](https://rest.sh/#/guide) | API validation per [ADR 003](../development/003-apis.md) | Optional |

### Development Environment

- Use [devcontainer-base](https://github.com/wagov-dtt/devcontainer-base) for standardized tooling
- Use [Justfiles](https://just.systems/man/en/) for task automation  
- Use [GitHub Actions](https://docs.github.com/en/actions/about-github-actions/understanding-github-actions) for CI/CD automation

**CI/CD Pipeline:**

```d2
direction: right

code: "Code Commit"
build: "Build & Test\nDocker Bake + SBOM"
qa: "Quality Assurance\nTrivy + Semgrep"
release: "Release\nStatic Artifacts"

code -> build -> qa -> release

release.note: "Consumed by\nADR 010 (Infrastructure)"
```

## Consequences

**Without this approach**: Vulnerable containers deployed, exposed secrets, compromised application integrity, and compliance violations.

**With this approach**: Secure, tested artifacts with automated vulnerability remediation and compliance alignment.

## References

- [ADR 003: API Documentation Standards](../development/003-apis.md)
- [ADR 010: Infrastructure as Code](../operations/010-configmgmt.md)
