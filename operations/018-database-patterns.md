# ADR 018: Database Patterns

**Status:** Proposed | **Date:** 2025-07-28

## Context

Applications need managed persistent storage (databases, datalakes, files, objects) with automatic scaling and
jurisdiction-compliant backup strategies.

- [AWS Aurora Serverless v2
  Documentation](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless-v2.html)
- [Percona Everest Documentation](https://docs.percona.com/everest/) and
  [Pigsty Documentation](https://pigsty.io/) for development/non-AWS
  environments
- [s3proxy](https://github.com/gaul/s3proxy) and [rclone serve s3](https://rclone.org/commands/rclone_serve_s3/) for development/non-AWS object storage

## Decision

Use [Aurora Serverless
v2](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless-v2.html)
outside EKS clusters with automated scaling, multi-AZ deployment, and
dual backup strategy. For datalakes, use SQL engines over object storage like [DuckLake](https://ducklake.select/) over [AWS S3](https://ducklake.select/docs/stable/duckdb/usage/choosing_storage) or [Trino](https://trino.io/docs/current/connector/iceberg.html) over [S3 tables](https://aws.amazon.com/blogs/storage/query-amazon-s3-tables-from-open-source-trino-using-apache-iceberg-rest-endpoint/)

### Implementation

- **Database**: Aurora Serverless v2 (PostgreSQL/MySQL) with built-in
  connection pooling and automatic scaling
- **Object Storage**: Amazon S3 and Amazon S3 Tables for datalakes, files and objects
- **Deployment**: Outside EKS cluster (handles complexity automatically)
- **Credentials**: Follow [ADR 005: Secrets
  Management](../security/005-secrets-management.md) for endpoint and
  credential management
- **Backup**: Follow [ADR 014: Object Storage
  Backups](014-object-backup.md) plus AWS automated snapshots
- **Security**: Follow [ADR 007: Centralized Security
  Logging](007-logging.md) and [ADR 012: Privileged Remote
  Access](../security/012-privileged-remote-access.md)

## Consequences

**Benefits:**

- Serverless scaling reducing operational costs during low usage periods
- Automated high availability with managed backup strategies per [ADR 014: Object Backup](014-object-backup.md)
- Compliance with jurisdiction requirements through dual backup approach

**Risks if not implemented:**

- High operational overhead managing database infrastructure
- Inconsistent backup strategies across database systems
- Cost inefficiency from overprovisioned database resources
