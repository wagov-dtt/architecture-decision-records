# ADR 010: Infrastructure as Code

**Status:** Accepted | **Date:** 2025-03-10

## Context

All environments must be reproducible from source to minimize drift and security risk. Manual changes and missing version control create deployment failures and vulnerabilities.

**Compliance Requirements:**

- [OWASP IaC Security](https://cheatsheetseries.owasp.org/cheatsheets/Infrastructure_as_Code_Security_Cheat_Sheet.html)
- [ACSC System Hardening](https://www.cyber.gov.au/resources-business-and-government/essential-cybersecurity/ism/cybersecurity-guidelines/guidelines-system-hardening)

## Decision

### Golden Path

1. **Git Repository Structure**: Single repo per application with `environments/{dev,staging,prod}` folders matching AWS account names (e.g., `app-a-infra` repo → `app-a-dev`, `app-a-staging`, `app-a-prod` accounts)
2. **State Management**: Terraform remote state with locking, separate state per environment
3. **CI Pipeline**:
   - **Validate**: Trivy scan + `terraform plan`/`kubectl diff` drift check
   - **Plan**: Show proposed changes on PR
   - **Apply**: Deploy on tagged release only
4. **Versioning**: Git tags = semantic versions (x.y.z) deployable to any environment
5. **Disaster Recovery**: Checkout tag + run `just deploy --env=prod` with static artifacts from [ADR 004](../development/004-cicd.md)

### Required Tools & Practices

| Tool | Purpose | Stage | Mandatory |
|------|---------|-------|-----------|
| [Trivy](https://trivy.dev/latest/docs/configuration/) | Vulnerability scanning | Validate | Yes |
| [Terraform](https://trivy.dev/latest/docs/coverage/iac/) or [kubectl/kustomize](https://kubectl.docs.kubernetes.io/guides/config_management/) | Configuration management | Deploy | Yes |
| [Justfiles](https://just.systems/man/en/) | Task automation | All | Recommended |
| [devcontainer-base](https://github.com/wagov-dtt/devcontainer-base) | Dev environment | Local | Recommended |
| [k3d](https://k3d.io/stable/) | Local testing | Dev | Optional |

**Infrastructure as Code Workflow:**

```d2
direction: right

artifacts: "Static Artifacts\n(ADR 004)"
infra_repo: "Infrastructure Repo\napp-x-infra"
environments: "AWS Accounts\napp-x-{dev,staging,prod}"

artifacts -> infra_repo -> environments

infra_repo.note: "Git tags = versions\nFolders = environments"
environments.note: "Consistent naming\nSeparate state storage"
```

## Consequences

**Benefits:**

- Reproducible infrastructure deployments with version control
- Automated drift detection and prevention mechanisms
- Reliable disaster recovery through infrastructure as code

**Risks if not implemented:**

- Configuration drift creating security vulnerabilities
- Failed rollbacks during critical incident recovery
- Inconsistent environments affecting application reliability

## References

- [ADR 001: Application Isolation](../security/001-isolation.md)
- [ADR 002: AWS EKS for Cloud Workloads](../operations/002-workloads.md)
- [ADR 005: Secrets Management](../security/005-secrets-management.md)
