# ADR 004: CI/CD Quality Assurance

**Status:** Accepted | **Date:** 2025-03-10

## Context

The goal is to ensure the security and integrity of software and
Infrastructure as Code (IAC) artifacts throughout the development
lifecycle. This ADR focuses on building, testing, and assuring software
artifacts that are then deployed via [ADR 010: Infrastructure as
Code](../operations/010-configmgmt.md). Threat actors exploit
vulnerabilities in code, software dependencies, build tooling, container
images, misconfigurations, and exposed secrets.

- [Open Web Application Security Project (OWASP) CI/CD Security Cheat
  Sheet](https://cheatsheetseries.owasp.org/cheatsheets/CI_CD_Security_Cheat_Sheet.html)
- [Australian Cyber Security Centre (ACSC) Guidelines for Software
  Development](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development)

## Decision

To address these risks, use a CI/CD pipeline with the following
standardised practices (or similar equivalents) for building software
and IAC artifacts. Infrastructure orchestration repositories should
consume these static, built, signed, and assured artifacts per [ADR 010:
Infrastructure as Code](../operations/010-configmgmt.md):

**CI/CD Pipeline Flow:**

Code Commit -> Build & Test -> Quality Assurance -> Release

Build & Test: {
  Compilation
  Unit Tests
  Static Analysis
}

Quality Assurance: {
  Vulnerability Scan
  Performance Test
  Security Check
}

Release: {
  Artifact Signing
  Deployment
  Monitoring
}
- Use [GitHub
  Actions](https://docs.github.com/en/actions/about-github-actions/understanding-github-actions)
  for CI/CD to **automate building and signing of container images**.
- Use [Justfiles](https://just.systems/man/en/) to **manage development
  tasks**.
- Use [devcontainer-base](https://github.com/wagov-dtt/devcontainer-base)
  for **standardized development environments** with pre-configured
  tooling including Docker, Trivy, Semgrep, and cloud CLIs.
- **Build container images** with [Docker
  Bake](https://docs.docker.com/build/bake/) for declarative,
  multi-platform builds with [provenance attestations and
  SBOM](https://docs.docker.com/build/attestations/) for supply chain
  security.
- Integrate
  [Trivy](https://trivy.dev/latest/docs/target/container_image/) for
  **vulnerability scanning of container images**.
- Use [Semgrep](https://semgrep.dev/docs/getting-started/quickstart) for
  **static code analysis** to find common issues.
- Use [Playwright](https://playwright.dev/docs/intro) for **end-to-end
  testing of web applications**.
- Use [Restish](https://rest.sh/#/guide) for **scripted validation of
  [ADR 003: API Documentation Standards](../development/003-apis.md)**.
- Use [Grafana
  K6](https://grafana.com/docs/k6/latest/get-started/write-your-first-test/)
  for **performance and reliability testing**.
- **Implement automated patching workflows** with vulnerability response
  timelines.
- **Automated vulnerability remediation** with pull request generation
  for security updates.
- Align development practices to [ACSC guidelines for software
  development](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development).

## Consequences

If we do not use these practices, we risk:

- Deploying containers with known vulnerabilities that attackers can
  exploit.
- Exposing sensitive information due to misconfigurations or hardcoded
  secrets.
- Compromising the integrity and reliability of our applications due to
  inadequate testing.
- Non-compliance with legislated requirements, leading to potential
  legal and reputational risks.

By adopting the above baseline for our CI/CD approach, we enhance the
security posture of our containerised applications, ensure compliance
with best practices, and maintain high-quality software delivery.
