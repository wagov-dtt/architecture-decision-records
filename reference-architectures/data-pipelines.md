# Reference Architecture: Data Pipelines

**Status:** Proposed | **Date:** 2025-01-28

## When to Use This Pattern

Use when building:

- Analytics and business intelligence reporting
- Data integration between organisational systems
- Automated data processing and transformation workflows

## Overview

This template implements scalable data pipelines using [Ibis](https://ibis-project.org/) for portable dataframe operations and [DuckLake](https://ducklake.select/) for lakehouse storage. The approach prioritises simplicity and portability - write transformations once in Python, run them anywhere from laptops to cloud warehouses.

## Core Components

```d2
direction: right

sources: Data Sources {
  Databases
  APIs
  Files
}

transform: Transformation {
  Ibis
  DuckDB
}

storage: Storage {
  DuckLake
  S3
}

output: Output {
  Quarto Reports
  Evidence BI
  Data API
}

sources -> transform -> storage -> output
```

**Key Technologies:**

| Component | Tool | Purpose |
|-----------|------|---------|
| **Transformation** | [Ibis](https://ibis-project.org/) | Portable Python dataframe API - same code runs on DuckDB, PostgreSQL, or cloud warehouses |
| **Local Engine** | [DuckDB](https://duckdb.org/) | Fast analytical queries, runs anywhere without infrastructure |
| **Lakehouse** | [DuckLake](https://ducklake.select/) | Open table format over S3 with ACID transactions |
| **Reporting** | [Quarto](https://quarto.org/) | Static reports from notebooks, version-controlled |

## Project Kickoff Steps

### Foundation Setup

1. **Apply Isolation** - Follow [ADR 001: Application Isolation](../security/001-isolation.md) for data processing network separation
2. **Deploy Infrastructure** - Follow [ADR 002: AWS EKS for Cloud Workloads](../operations/002-workloads.md) for container deployment
3. **Configure Infrastructure** - Follow [ADR 010: Infrastructure as Code](../operations/010-configmgmt.md) for reproducible infrastructure
4. **Setup Storage** - Follow [ADR 018: Database Patterns](../operations/018-database-patterns.md) for S3 and DuckLake configuration

### Security & Operations

1. **Configure Secrets** - Follow [ADR 005: Secrets Management](../security/005-secrets-management.md) for data source credentials
2. **Setup Logging** - Follow [ADR 007: Centralised Security Logging](../operations/007-logging.md) for audit trails
3. **Setup Backups** - Follow [ADR 014: Object Storage Backups](../operations/014-object-backup.md) for data backup
4. **Data Governance** - Follow [ADR 015: Data Governance Standards](../operations/015-data-governance.md) for data quality

### Development Process

1. **Configure CI/CD** - Follow [ADR 004: CI/CD Quality Assurance](../development/004-cicd.md) for automated testing
2. **Setup Releases** - Follow [ADR 009: Release Documentation Standards](../development/009-release.md) for versioning
3. **Analytics Tools** - Follow [ADR 017: Analytics Tooling Standards](../operations/017-analytics-tooling.md) for Quarto integration

## Implementation Details

**Why Ibis + DuckDB:**

- **Portability**: Write transformations in Python, run on any backend (DuckDB locally, PostgreSQL, BigQuery, Snowflake)
- **Simplicity**: No complex orchestration infrastructure required for most workloads
- **Performance**: DuckDB handles analytical queries on datasets up to hundreds of gigabytes on a single machine
- **Cost**: Run development and small-medium workloads without cloud compute costs

**When to Scale Beyond DuckDB:**

- Data exceeds available memory/disk on a single node
- Need concurrent writes from multiple processes
- Require real-time streaming ingestion

**Data Quality:**

- Use Ibis expressions for data validation
- Implement schema checks in CI/CD pipeline
- Track data lineage through transformation code in git

**Cost Optimisation:**

- Run DuckDB locally for development and testing (zero infrastructure cost)
- Use S3 Intelligent Tiering for automatic archival
- Scale to cloud warehouses only when data volume requires it
