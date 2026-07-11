# ADR 018: Managed Relational Databases and Open Lakehouses

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

## Synopsis

- **Use when:** Selecting transactional database hosting or an analytical
  lakehouse pattern across cloud or legacy estates.
- **Avoid when:** Durable database state would be kept in Kubernetes, a
  transactional database would become the default data lake, or managed
  snapshots would be treated as complete backup compliance.
- **Decision:** Prefer evidence-selected managed relational services for new
  transactional workloads and decoupled open-format lakehouse components for
  analytical workloads, while retaining viable supported legacy databases.
- **Required evidence:** Selection and exit record, performance and recovery
  tests, independent backup evidence, lakehouse interoperability and lineage,
  and migration reconciliation.
- **Dependencies:** [ADR 014: Independent Backups and
  Recovery](014-object-backup.md) for independent copies and tested restoration.

## Context

Transactional applications and analytical platforms need different data
patterns. The selection must work across AWS, Azure, Google Cloud, and legacy
estates without mandating one database product or claiming that a managed
feature satisfies every operational or compliance control.

## Decision

Prefer a supported managed relational database for new transactional workloads
when it meets functional, security, region, recovery, cost, and exit needs.
Keep durable database state outside Kubernetes. Existing supported databases
may remain where migration risk or cost outweighs the benefit and an adequate
operating and recovery model exists.

Select the engine and service using tested requirements for SQL and extension
compatibility, consistency, availability, maintenance, private connectivity,
identity, encryption, observability, capacity, latency, Australian-region and
data-location needs, support, total cost, and data export.

Connection pooling is a separate design decision. Use and test a service,
proxy, or application pool only when workload concurrency requires it; do not
assume every managed database includes suitable pooling.

Managed snapshots and point-in-time recovery support operational recovery but
do not by themselves prove backup or retention compliance. Apply the
independent-copy and restore-test requirements in [ADR 014](014-object-backup.md).

### Open Lakehouse Pattern

For analytical data, separate object storage, open table format, catalogue,
governance, and query or processing engines. Prefer open formats, such as
[Apache Iceberg](https://iceberg.apache.org/), where they meet interoperability
and lifecycle needs. Select engines by concurrency, update semantics, workload
size, cost, support, and portability rather than using a transactional database
as a default data lake.

[DuckLake](https://ducklake.select/) with DuckDB is an option for lightweight,
local, or scheduled analytical workloads. Distributed or managed engines are
appropriate when concurrency, scale, governance, or operating support requires
them.

### Provider Examples

Products are options rather than exact equivalents; validate current region,
engine, feature, and open-format support.

| Provider | Managed relational examples | Open-lakehouse building blocks |
|---|---|---|
| AWS | [Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html) or [Amazon Aurora](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) | Amazon S3 with [S3 Tables](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables.html) or an approved Iceberg catalogue and query engine |
| Azure | [Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/sql-database-paas-overview) or [Azure Database for PostgreSQL](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/overview) | [Azure Data Lake Storage Gen2](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction) with an approved open-table catalogue and query engine |
| Google Cloud | [Cloud SQL](https://cloud.google.com/sql/docs/introduction) or [AlloyDB](https://cloud.google.com/alloydb/docs/overview) | Cloud Storage with [BigLake Iceberg tables](https://cloud.google.com/bigquery/docs/iceberg-tables) or another approved Iceberg-compatible catalogue and engine |

### Migration

Before migration, inventory schemas, data types, extensions, collation, stored
code, clients, integrations, availability and recovery behaviour, performance,
and licensing. Pilot representative load; define data reconciliation, cutover,
rollback, and coexistence; test restore and export; then remove old copies and
access only after acceptance and retention requirements are met.

## Required Evidence

- Selection record covering requirements, provider and region fit, security,
  availability, support, total cost, and exit or export path
- Performance, failover, connection, maintenance, restore, and recovery test
  results against approved service objectives
- Backup evidence under ADR 014 rather than reliance on a feature declaration
- For lakehouses, table-format and catalogue ownership, interoperability and
  schema-evolution tests, lineage, retention, and engine compatibility
- Migration reconciliation, rollback test, approvals, and decommission record

## Exceptions

Self-managed databases, closed analytical formats, unavailable independent
backups, or unmet region and exit requirements need a time-bound exception with
alternatives, compensating controls, residual risk, owner, approval, expiry,
and reassessment date.

## Consequences

**Benefits:** services are selected by workload evidence while open analytical
formats reduce unnecessary engine coupling.

**Trade-offs:** portability is not automatic, managed products differ, and
migration and independent recovery still require engineering and testing.
