# ADR 004: CI/CD Quality Assurance

**Status:** Accepted | **Date:** 2025-03-10

## Context

Ensure security and integrity of software artifacts that are consumed by
infrastructure repositories per [ADR 010](../operations/010-configmgmt.md).
Threat actors exploit vulnerabilities in code, dependencies, container
images, and exposed secrets.

**Compliance Requirements:**

- [OWASP CI/CD Security](https://cheatsheetseries.owasp.org/cheatsheets/CI_CD_Security_Cheat_Sheet.html)
- [ACSC Software Development Guidelines](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development)

## Decision

### CI/CD Pipeline Requirements

**Pipeline Flow**: Code Commit → Build & Test → Quality Assurance → Release

| Stage | Tools | Purpose | Mandatory |
|-------|-------|---------|-----------|
| **Build** | [Docker Bake](https://docs.docker.com/build/bake/) | Multi-platform builds with SBOM/provenance | Yes |
| **Scan** | [scc](https://github.com/boyter/scc) and [Trivy](https://trivy.dev/latest/docs/target/container_image/) | Complexity and Vulnerability scanning | Yes |
| **Analysis** | [GitHub CodeQL](https://docs.github.com/en/code-security/code-scanning/introduction-to-code-scanning/about-code-scanning-with-codeql) | Static code analysis | Yes |
| **Test** | [Playwright](https://playwright.dev/docs/intro) | End-to-end testing | Recommended |
| **Performance** | [Grafana K6](https://grafana.com/docs/k6/latest/get-started/write-your-first-test/) | Load testing | Optional |
| **API** | [Restish](https://rest.sh/#/guide) | API validation per [ADR 003](../development/003-apis.md) | Optional |

### Execution Environment Requirements

- Use [devcontainer-base](https://github.com/wagov-dtt/devcontainer-base)
  for standardised tooling
- Use [Docker Bake](https://docs.docker.com/build/bake/) to define and
  standardise build processes
- Use [Justfiles](https://just.systems/man/en/) for task automation
- Use [GitHub Actions](https://docs.github.com/en/actions/about-github-actions/understanding-github-actions)
  for repository-hosted CI checks that do not require privileged access
  into AWS environments
- Where CI/CD automation must operate within an AWS context using an AWS
  role, [Woodpecker CI](https://woodpecker-ci.org/) may be used from an
  operations workstation or operations-controlled environment
- Woodpecker runners and agents must run in an isolated, strictly
  controlled environment with strong access control, audit logging, and
  minimal administrative access
- Do not place AWS-privileged CI/CD automation in low-control
  environments such as GitHub-hosted execution where the organisation
  does not control the runtime boundary

### Operations-Controlled Automation

Use operations-controlled automation only where deployment or release
steps need AWS credentials or direct access to AWS-hosted systems.
Preferred controls:

- Assume AWS roles at runtime rather than storing long-lived cloud
  credentials in pipeline systems
- Run [Woodpecker agents](https://woodpecker-ci.org/docs/administration/configuration/agent)
  only on dedicated hosts or workloads managed by operations
- Configure Woodpecker using its documented
  [GitHub forge integration](https://woodpecker-ci.org/docs/administration/configuration/forges/github)
  only as the source control integration point, not as the privileged
  execution environment
- Deploy and maintain Woodpecker using a controlled installation method
  such as the documented
  [Docker Compose installation](https://woodpecker-ci.org/docs/administration/installation/docker-compose)
  or equivalent platform-managed deployment
- Restrict network paths from the automation environment to only the AWS
  services and internal systems required for the job
- Keep build, release, and deployment logs for audit and incident review

**CI/CD Pipeline:**

```d2
direction: right

code: Code Commit
build: Build
scan: Scan + Analyse
release: Release

code -> build -> scan -> release
```

Build produces container images with SBOM/provenance. Scan runs
vulnerability and static analysis. Release produces static artifacts
consumed by [ADR 010: Infrastructure as Code](../operations/010-configmgmt.md).
Where release automation needs AWS access, run it from an
operations-controlled environment rather than a low-control external
runtime.

## Consequences

**Benefits:**

- Automated security scanning and vulnerability remediation
- Standardised artifact integrity and compliance alignment
- Consistent deployment pipelines with audit trails
- Clearer separation between general CI checks and AWS-privileged
  automation

**Risks if not implemented:**

- Vulnerable containers deployed to production
- Exposed secrets or excessive cloud privilege in automation systems
- Manual security processes prone to human error
- Compliance violations and audit failures

## References

- [ADR 003: API Documentation Standards](../development/003-apis.md)
- [ADR 010: Infrastructure as Code](../operations/010-configmgmt.md)