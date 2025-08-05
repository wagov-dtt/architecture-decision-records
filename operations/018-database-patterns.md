---
title: 'ADR 018: Database Patterns'
date: 2025-07-28T00:00:00.000Z
status: Proposed
tags:
  - infrastructure
  - database
  - aurora
related:
  - '005'
  - '014'
  - '007'
  - '012'
---


**Status:** Proposed \| **Date:** 2025-07-28

## Context

Applications need managed databases with automatic scaling and
jurisdiction-compliant backup strategies.

- [AWS Aurora Serverless v2
  Documentation](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless-v2.html)
- [Percona Everest Documentation](https://docs.percona.com/everest/) and
  [Pigsty Documentation](https://pigsty.io/) for development/non-AWS
  environments

## Decision

Use [Aurora Serverless
v2](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless-v2.html)
outside EKS clusters with automated scaling, multi-AZ deployment, and
dual backup strategy.

### Implementation

- **Database**: Aurora Serverless v2 (PostgreSQL/MySQL) with built-in
  connection pooling and automatic scaling
- **Deployment**: Outside EKS cluster (handles complexity automatically)
- **Credentials**: Follow [ADR 005: Secrets
  Management](../security/005-secrets-management.qmd) for endpoint and
  credential management
- **Backup**: Follow [ADR 014: Object Storage
  Backups](014-object-backup.qmd) plus AWS automated snapshots
- **Security**: Follow [ADR 007: Centralized Security
  Logging](007-logging.qmd) and [ADR 012: Privileged Remote
  Access](../security/012-privileged-remote-access.qmd)

## Consequences

### Benefits

- **Cost Efficiency**: Serverless scaling reduces costs during low usage
- **Low Maintenance**: Managed service with automatic scaling and high
  availability
- **Compliance**: Dual backup strategy meets jurisdiction requirements

### Trade-offs

- **Vendor Lock-in**: AWS-specific (consider [Percona
  Everest](https://www.percona.com/software/percona-everest) or
  [Pigsty](https://pigsty.io/) for development/non-AWS)
- **Cold Start**: Brief delays when scaling from zero
