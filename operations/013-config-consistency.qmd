---
title: "ADR 013: Configuration State Management"
date: 2025-07-22
status: Proposed
tags:
- #operations
- #infrastructure
- #terraform
- #kubernetes
- #gitops
---

## Status

Proposed

## Context

Infrastructure as Code configurations can drift from their declared state in git repositories, creating inconsistencies between intended and actual infrastructure. Manual changes and missing version control alignment result in unreliable environment recreation and failed rollbacks across development, staging, and production environments.

Current issues:

- Local state storage without team access or backup
- Manual configuration changes bypassing version control
- Missing automated drift detection
- Inconsistent environment provisioning from git

- [Cloud Native Computing Foundation (CNCF) Cloud native landscape](https://landscape.cncf.io/)
- [Terraform Best Practices](https://developer.hashicorp.com/terraform/cloud-docs/recommended-practices)

## Decision

Use strict configuration management practices ensuring git repository and release tag consistency:

**Git Repository Structure:**

- Single repository for all environment configurations
- Environment-specific directories with shared modules
- Branch protection rules for main/production branches
- Required reviews for all configuration changes

**Release Tagging:**

- Git tags must correspond to deployed infrastructure versions
- Semantic versioning for infrastructure releases (v1.0.0, v1.1.0)
- Automated tag creation through CI/CD pipeline
- Tag annotations include deployment manifest checksums

**State Management:**

- Remote state storage with locking for Terraform
- GitOps approach for Kubernetes configuration management
- Environment isolation with separate state storage
- Regular state validation and drift detection
- Cross-region backup of state files

**Deployment Consistency:**

- Each environment deployable from specific git tag
- Automated drift detection and remediation
- Immutable infrastructure deployments where possible
- Configuration validation before deployment

## Consequences

**Risks of not implementing:**

- Configuration drift between environments
- Inability to reliably recreate environments
- Failed rollbacks due to state inconsistencies
- Security vulnerabilities from untracked configuration changes
- Compliance issues from lack of audit trail
- Deployment failures in production environments
