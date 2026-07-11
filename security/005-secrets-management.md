# ADR 005: Secrets Management

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

## Synopsis

- **Use when:** Storing, delivering, rotating, or auditing application,
  automation, or administrative secrets.
- **Avoid when:** Source code, configuration, images, logs, prompts, or
  Kubernetes Secrets would become the authoritative long-term secret store.
- **Decision:** Use an agency-approved managed secret service as the system of
  record, prefer workload identity and short-lived credentials, and enforce
  ownership, least privilege, encryption, rotation, scanning, and auditing.
- **Required evidence:** Secret inventory, access and encryption configuration,
  rotation and secret-scan results, and central administrative-access records.
- **Dependencies:** None.

## Context

Per the [Open Web Application Security Project (OWASP) Secrets
Management Cheat
Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html):

> Organisations face a growing need to centralise the storage,
> provisioning, auditing, rotation and management of secrets to control
> access to secrets and prevent them from leaking and compromising the
> organisation.

Static secrets create disclosure and rotation risk. Location alone does not
make a secret safe: access policy, identity, encryption, auditability,
lifetime, and recovery determine the effective control.

## Decision

An agency-approved managed secret service must be the system of record for
application, automation, and administrative secrets. Segment stores and
access policies by environment and trust boundary. Workloads should
authenticate using workload identity and short-lived, dynamically issued
credentials instead of stored credentials wherever the target service
supports them.

### Secret Rotation

Each secret must have an owner, expiry or review date, and a rotation method
based on its lifetime, privilege, exposure, service capability, and impact
of compromise. Revoke and replace secrets immediately after suspected
disclosure.

Automate rotation where practical, prioritising high-consequence and
widely shared secrets. Manual rotation is acceptable when risk-assessed,
owned, tested, and evidenced; being manual does not by itself require an
exception.

### Kubernetes Secrets

A Kubernetes Secret is a delivery and storage object, not inherently safer
than a managed secret service. Namespace scoping does not prevent access by
cluster administrators or a compromised control plane. If used, enable
encryption at rest, tightly scope RBAC and workload identities, prevent
logging or environment leakage, and minimise persistence. Direct runtime
retrieval, a CSI driver, or a synchronisation operator are all acceptable
when the managed service remains authoritative and the threat model supports
the delivery method.

One-time operations should retrieve secrets only for the task lifetime and
must not expose them in command arguments, shell history, logs, or temporary
files. Runtime secrets must not be stored in source repositories; encrypted
test fixtures must keep decryption identities outside the repository.

### Provider Examples

Equivalent managed systems of record include:

- [AWS Secrets Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html)
- [Azure Key Vault secrets](https://learn.microsoft.com/en-us/azure/key-vault/secrets/about-secrets)
- [Google Secret Manager](https://cloud.google.com/secret-manager/docs/overview)

### Required Controls

- Do not hard-code secrets in source code, images, infrastructure
  definitions, logs, prompts, or configuration files
- Encrypt secrets in transit and at rest and restrict decryption to the
  workload or administrator that requires it
- Prefer short-lived, dynamically issued credentials over static secrets
- Grant retrieval and management permissions separately and by least
  privilege
- Scan repositories, build artifacts, and logs for exposed secrets and
  revoke exposed credentials immediately
- Record secret ownership, purpose, consumers, rotation method, and last
  rotation without recording the secret value
- Log administrative access, rotation, and failed retrieval without logging
  secret material

This ADR covers application secrets, credentials, and their encryption. It
does not define an agency-wide cryptographic algorithm, key-management,
certificate-management, or post-quantum transition standard.

## Required Evidence

- Secret inventory containing owner, consumer, storage location, and
  rotation requirements
- Access-policy and encryption configuration
- Rotation and secret-scanning results
- Central audit records for administrative access and failed retrieval

## Exceptions

Storage outside an agency-approved system of record, unencrypted secret
storage, or inability to meet the assessed rotation requirement needs a
time-bound exception with compensating controls, residual risk, accountable
executive approval, expiry date, and reassessment date.

## Consequences

**Benefits:**

- Consistent access control, audit, and lifecycle management
- Defined rotation periods and automation where practical reduce human
  error
- Meets compliance and auditing requirements

**Risks:**

- Security exposure from manual handling
- Non-compliance without proper implementation

**Trade-offs:**

- Runtime retrieval and synchronisation components add availability and
  operational dependencies
