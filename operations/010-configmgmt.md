# ADR 010: Infrastructure as Code

**Status:** Accepted | **Date:** 2025-03-10

## Context

Infrastructure as Code requires security, integrity, and state
consistency throughout the deployment lifecycle. Configuration drift
from manual changes and missing version control create deployment
failures and security vulnerabilities.

- [Open Web Application Security Project (OWASP) Infrastructure as Code
  Security
  Guidance](https://cheatsheetseries.owasp.org/cheatsheets/Infrastructure_as_Code_Security_Cheat_Sheet.html)
- [Australian Cyber Security Centre (ACSC) Guidelines for System
  Hardening](https://www.cyber.gov.au/resources-business-and-government/essential-cybersecurity/ism/cybersecurity-guidelines/guidelines-system-hardening)
- [Terraform Best
  Practices](https://developer.hashicorp.com/terraform/cloud-docs/recommended-practices)

## Decision

Use Infrastructure as Code with git-based workflows and state
management:

### Security & Configuration

- Use [Trivy](https://trivy.dev/latest/docs/configuration/) for
  vulnerability and misconfiguration scanning
- Use [kubectl &
  kustomize](https://kubectl.docs.kubernetes.io/guides/config_management/)
  or [Terraform](https://trivy.dev/latest/docs/coverage/iac/) for
  configuration management
- Use [Justfiles](https://just.systems/man/en/) for operations task
  automation
- Follow [ADR 001: Application Isolation](../security/001-isolation.md)
  and [ADR 005: Secrets
  Management](../security/005-secrets-management.md)

### State Management & Git Workflow

- Single repository for all environment configurations with
  environment-specific directories
- Git tags must correspond to deployed infrastructure versions using
  semantic versioning
- Remote state storage with locking for Terraform, GitOps for Kubernetes
- Environment isolation with separate state storage and cross-region
  backup
- Branch protection rules and required reviews for configuration changes

**Infrastructure as Code Workflow:**

Git Changes -> Security Validation -> Terraform -> Environments

Git Changes: {
  Pull Request
  Review
  Merge
}

Security Validation: {
  Trivy Scan
  Drift Detection
  Policy Check
}

Terraform: {
  State Management
  Infrastructure Provisioning
  GitOps Deployment
}

Environments: {
  Development
  Staging
  Production
}

### Deployment Consistency

- Each environment deployable from specific git tag
- Automated drift detection and configuration validation before
  deployment
- Test releases locally with [k3d](https://k3d.io/stable/) and on EKS
  per [ADR 002: AWS EKS for Cloud
  Workloads](../operations/002-workloads.md)

## Consequences

### Risks of not implementing

- Known vulnerabilities and misconfigurations deployed to production
- Configuration drift causing deployment failures and inconsistent
  environments
- Exposed secrets and compliance violations
- Failed rollbacks due to state inconsistencies

### Benefits

- Secure, consistent infrastructure deployments
- Reliable environment recreation from git tags
- Automated vulnerability detection and drift prevention
