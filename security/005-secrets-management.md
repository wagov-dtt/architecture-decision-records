# ADR 005: Secrets Management

**Status:** Accepted | **Date:** 2025-02-25

## Context

Per the [Open Web Application Security Project (OWASP) Secrets
Management Cheat
Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html):

> Organisations face a growing need to centralise the storage,
> provisioning, auditing, rotation and management of secrets to control
> access to secrets and prevent them from leaking and compromising the
> organisation.

Secrets should be accessed at runtime by workloads and never be hard-coded
or stored in plain text. In Kubernetes environments, the principle of
"local over global" minimises attack surface. Secrets adjacent to their
workload reduce blast radius. Account-wide secret stores increase exposure.

## Decision

Use [AWS Secrets
Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html)
for administrative and CI/CD operations. For Kubernetes workloads, prefer
namespace-scoped secrets and minimise reliance on account-wide stores.

### Security Hierarchy: Local > Global

| Approach | Blast Radius | Use Case |
|----------|--------------|----------|
| Ephemeral (ad-hoc fetch) | None | One-time ops |
| Kubernetes Secret (namespace-scoped) | Single namespace | Default for app runtime |
| External Secrets Operator | Namespace (syncs from account-wide) | Bridge existing AWS-managed secrets |
| AWS Secrets Manager (account-wide) | Entire AWS account | Admin/CI only |

**Principle**: Secrets adjacent to their workload minimise attack surface.
Account-wide stores increase exposure because any compromised credential in
that account may gain access to them.

### Secret Rotation

Every system design should define secret rotation periods and the
automation or manual process used to meet them.

- **Database credentials**: 30-90 days (automate via Secrets Manager)
- **API keys**: 90 days or on suspected compromise
- **Certificates**: Before expiry (automate via ACM where possible)

### Kubernetes Secrets

Workloads should use namespace-local Kubernetes Secrets, protected at rest
with [Elastic Kubernetes Service (EKS) envelope encryption using AWS Key
Management Service (KMS)](https://docs.aws.amazon.com/eks/latest/userguide/envelope-encryption.html).
This is the default for EKS 1.28+.

#### Ad-hoc Operations

For one-time tasks (DB migrations, user creation), fetch secrets ephemerally
rather than storing them. Use stdin/stdout piping and HereDoc patterns so
secrets travel via standard input instead of command-line arguments,
keeping them out of process lists (`ps`). See [detailed examples and
patterns](https://github.com/wagov-dtt/tutorials-and-workshops/tree/main/secrets).

#### Encrypted Repository Fixtures

For low-sensitivity secrets that must live with source code, such as test
fixtures, store only encrypted values in the repository using the
[age CLI](https://github.com/FiloSottile/age). Do not use this for runtime
application secrets. Never commit the age private key, identity file, or
passphrase to the repository.

#### External Secrets Operator (Fallback)

When secrets must live in AWS for organisational reasons, ESO bridges AWS
Secrets Manager to Kubernetes. It's useful but not the default.

**Why ESO over Sealed Secrets:**

- Secrets stay in Secrets Manager (single source of truth, audit logging)
- Auto-sync to Kubernetes with configurable refresh
- Uses Pod Identity (no AWS keys in cluster)
- No encrypted blobs in git (unlike Sealed Secrets)

ESO flow: `AWS Secrets Manager -> ExternalSecret -> Kubernetes Secret`

### IAM and Access Control

[Use IAM policy
statements](https://docs.aws.amazon.com/secretsmanager/latest/userguide/best-practices.html#w21aab9c19)
to enforce least-privilege access. Pods should not call AWS Secrets
Manager directly at runtime. Use namespace-scoped Kubernetes Secrets or
ESO instead.

## Consequences

**Benefits:**

- Reduced attack surface through localised storage
- Defined rotation periods and automation where practical reduce human
  error
- Meets compliance and auditing requirements

**Risks:**

- Security exposure from manual handling
- Non-compliance without proper implementation

**Trade-offs:**

- AWS vendor dependency may complicate future migrations
- ESO adds complexity compared to native K8s Secrets
