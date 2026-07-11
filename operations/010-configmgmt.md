# ADR 010: Infrastructure and Configuration as Code

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

## Synopsis

- **Use when:** Provisioning or recovering cloud, network, identity, Kubernetes,
  operating-system, or supported platform configuration.
- **Avoid when:** Changes would remain manual, unreconciled, non-reproducible, or
  dependent on a developer workstation without recorded justification and
  equivalent controls.
- **Decision:** Manage infrastructure declaratively in version control,
  preferring OpenTofu or Terraform, with protected promotion, reviewed plans,
  secured state, drift detection, controlled imports, and tested recovery.
- **Required evidence:** Baselines, plans and approvals, artifact and dependency
  versions, state protection and recovery, import records, scans, and drift
  remediation.
- **Dependencies:** [ADR 009: Release Standards](../development/009-release.md)
  for protected promotion of immutable configuration commits or artifacts.

## Context

Cloud and legacy environments must be reproducible and recoverable without
assuming one provider, repository layout, branch name, or release-tag scheme.
Uncontrolled manual changes and insecure state create drift and recovery risk.

- [OWASP Infrastructure as Code Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Infrastructure_as_Code_Security_Cheat_Sheet.html)
- [ACSC Guidelines for System Hardening](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-system-hardening)

## Decision

Manage infrastructure and supported platform configuration declaratively from
version control. Scope includes cloud resources, networks, identity and policy
assignments, Kubernetes resources, operating-system and platform baselines, and
the configuration needed to recover a service.

Use [OpenTofu](https://opentofu.org/docs/) or
[Terraform](https://developer.hashicorp.com/terraform/docs) as the preferred
infrastructure provisioning layer across cloud providers. Their mature provider
ecosystems, declarative plans, state model, policy integration, import workflows,
and common review experience provide a more consistent capability and audit trail
than using a different proprietary framework for each provider.

Prefer OpenTofu for new implementations where its providers and ecosystem meet the
requirement. Terraform remains supported where existing modules, managed services,
vendor support, or organisational capability justify it.

### Required Practices

1. Select a repository model by ownership and change coupling. Application,
   environment, and platform repositories may be separate; document how a
   released service resolves every required configuration version.
2. Promote an immutable commit or build artifact through environments using
   protected approvals under [ADR 009](../development/009-release.md). Tags and
   semantic versions are optional release mechanisms, not assumed requirements.
3. Validate syntax, security, policy, and supported-version baselines; produce
   a reviewed change plan before apply; record the apply result.
4. Detect drift. Automatically remediate high-risk drift only where the action
   and rollback are tested; otherwise alert an accountable owner.
5. Disable unnecessary services and insecure defaults, apply least privilege,
   and expose only approved interfaces.
6. Keep modules, providers, deployment tooling, and static artifacts pinned or
   otherwise reproducible. Test bootstrap and recovery without relying on a
   developer workstation.
7. Capture a saved, reviewed plan for controlled production changes and apply the
   approved plan or otherwise verify that the applied change matches review.
8. Keep reusable modules small, versioned, tested, and owned. Review provider and
   module provenance before adoption.

Environment names and their mapping to AWS accounts, Azure subscriptions,
Google Cloud projects, clusters, or on-premises zones must be documented, but
this ADR does not prescribe folder names or a one-account-per-folder layout.

### State and Existing Resources

Store remote state with encryption, least-privilege access, concurrency
control, version recovery, audit logging, and backup. Separate production
state administration from ordinary workload access. Prevent secrets entering
state where possible and protect unavoidable sensitive state as a secret.

Discover and import existing resources before bringing them under management.
Review the import and a no-op baseline plan to ensure adoption will not replace,
delete, or reset production resources. Reconcile unsupported settings and
record resources that must remain outside declarative management. See the
[Terraform import workflow](https://developer.hashicorp.com/terraform/cli/import)
as one implementation example.

### Native Frameworks and Bootstrap

Provider-native frameworks can be used where OpenTofu or Terraform lacks a required
capability, where a managed service generates and controls the deployment, or to
bootstrap the remote state, identity, and organisation foundations needed by the
preferred layer. Record the reason and preserve equivalent review, plan, state,
testing, and audit evidence.

Examples include [AWS CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html),
[Azure Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview),
and [Google Cloud Infrastructure Manager](https://cloud.google.com/infrastructure-manager/docs/overview).
These are exception or bootstrap options, not the default delivery layer.

Use configuration-management and image-building tools alongside OpenTofu or
Terraform for guest operating systems, network appliances, and legacy or
on-premises platforms. Keep inventories versioned, changes idempotent, and recovery
tested.

This ADR controls configuration deployment and drift. It does not by itself
set vulnerability-scanning cadence, patch deadlines, or technology replacement
plans.

## Required Evidence

- Version-controlled baseline, environment mapping, approvals, plans, apply
  records, and resolved artifact versions for each production release
- OpenTofu or Terraform version, provider lock file, module versions, saved or
  reviewed production plan, and evidence that the approved change was applied
- State access configuration, audit records, backup, and successful state or
  control-plane recovery test
- Existing-resource inventory, import records, reviewed baseline plan, and
  exclusions from declarative management
- Security and policy results, drift findings, remediation records, and current
  supported-version settings

## Exceptions

Use of a provider-native framework as the primary provisioning layer, emergency
manual changes, or baseline deviations must be recorded and justified. Manual or
out-of-band changes must be time-bound, monitored for drift, reconciled back into
code where possible, and approved with compensating controls, residual risk, owner,
expiry, and reassessment date.

## Consequences

**Benefits:** reviewed, declarative configuration improves consistency,
recoverability, and evidence across providers.

**Trade-offs:** importing existing estates is effortful, state is sensitive,
and not every legacy interface can be safely automated.
