---
title: "ADR 018: Database Patterns"
description: "Applications need managed persistent storage for databases, datalakes,"
weight: 180
toc: true
---

## ADR 018: Database Patterns

**Status:** Proposed | **Date:** 2025-07-28

### Context

Applications need managed persistent storage for databases, datalakes,
and objects with automatic scaling and jurisdiction-compliant backup
strategies. Workloads that need shared file-system access are covered by
[ADR 019: Shared File Access](/docs/operations/019-shared-file-access/).

- [AWS Aurora Serverless v2
  Documentation](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless-v2.html)
- [Percona Everest Documentation](https://docs.percona.com/everest/) and
  [Pigsty Documentation](https://pigsty.io/) for development/non-AWS
  environments
- [DuckLake](https://ducklake.select/) for lightweight lakehouse
  storage over object storage
- [Amazon S3 Tables](https://aws.amazon.com/s3/features/tables/) for
  managed [Apache Iceberg](https://iceberg.apache.org/) tables
- [s3proxy](https://github.com/gaul/s3proxy) and [rclone serve
  s3](https://rclone.org/commands/rclone_serve_s3/) for
  development/non-AWS object storage

### Decision

Use [Aurora Serverless
v2](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless-v2.html)
outside EKS clusters with automated scaling, multi-AZ deployment, and
dual backup strategy.

**Datalakes:** Separate the storage format from the access layer:

- **Storage layer**: store analytical data in object storage with open
  table formats
- **Lightweight access layer**: use [DuckLake](https://ducklake.select/)
  with a [DuckDB](https://duckdb.org/) client for local development,
  scheduled jobs, and simpler analytical workloads
- **Serverless Iceberg access layer**: use [Amazon S3
  Tables](https://aws.amazon.com/s3/features/tables/) for managed
  [Apache Iceberg](https://iceberg.apache.org/) tables when workloads
  need AWS-managed table maintenance or multi-engine access
- **Distributed query access layer**: use
  [Trino](https://trino.io/docs/current/connector/iceberg.html) or
  equivalent Iceberg-compatible engines when workloads need concurrent
  or larger-scale querying

DuckLake and S3 Tables are not an either/or decision. Choose the access
layer per workload while keeping data in object storage and open table
formats where practical. See [Reference Architecture: Data
Pipelines](/docs/reference-architectures/data-pipelines/) for full
datalake patterns.

#### Implementation

- **Database**: Aurora Serverless v2 (PostgreSQL/MySQL) with built-in
  connection pooling and automatic scaling
- **Datalake Storage**: S3-compatible object storage with open table
  formats for analytics data
- **Datalake Access**: DuckDB clients for DuckLake workloads; S3 Tables,
  Trino, or equivalent Iceberg-compatible engines for serverless or
  distributed access
- **Object Storage**: Amazon S3 for files and objects. Use [ADR 019:
  Shared File Access](/docs/operations/019-shared-file-access/) when workloads need
  file-system access to object-backed files
- **Deployment**: Outside EKS cluster (handles complexity automatically)
- **Credentials**: Follow [ADR 005: Secrets
  Management](/docs/security/005-secrets-management/) for endpoint and
  credential management
- **Backup**: Follow [ADR 014: Object Storage
  Backups](/docs/operations/014-object-backup/) plus AWS automated snapshots
- **Security**: Follow [ADR 007: Centralised Security
  Logging](/docs/operations/007-logging/) and [ADR 012: Privileged Remote
  Access](/docs/security/012-privileged-remote-access/)

### Consequences

**Benefits:**

- Serverless scaling reducing operational costs during low usage periods
- Automated high availability with managed backup strategies per [ADR 014: Object Backup](/docs/operations/014-object-backup/)
- Compliance with jurisdiction requirements through dual backup approach

**Risks if not implemented:**

- High operational overhead managing database infrastructure
- Inconsistent backup strategies across database systems
- Cost inefficiency from overprovisioned database resources
