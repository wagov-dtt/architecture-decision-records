# Reference Architecture: Data Pipelines

**Status:** Proposed | **Date:** 2025-01-28

## When to Use This Pattern

Use when building:

- Analytics and business intelligence reporting
- Data integration between organisational systems
- Automated data processing and transformation workflows

## Overview

This template implements scalable data pipelines using SQLMesh for orchestration, S3 for storage, and modern analytics engines (DuckDB/DuckLake) for querying. Suitable for both new data platforms and migration from legacy tools.

## Core Components

```d2
Data Sources -> SQLMesh -> S3 Storage
SQLMesh -> Aurora PostgreSQL
S3 Storage -> Analytics Engine
Analytics Engine -> Reports

Data Sources: {
  Databases
  APIs
  Files
}

SQLMesh: {
  Orchestration
  Transformation
  Quality Checks
}

S3 Storage: Raw & Processed Data
Aurora PostgreSQL: Metadata & Schema
Analytics Engine: DuckDB/Athena

Reports: {
  Quarto
  Evidence BI
  Data API
}
```

## Project Kickoff Steps

### Foundation Setup

1. **Apply Isolation** - Follow [ADR 001: Application
    Isolation](../security/001-isolation.md) for data processing
    network and runtime separation
2. **Deploy Infrastructure** - Follow [ADR 002: AWS EKS for Cloud
    Workloads](../operations/002-workloads.md) for SQLMesh container
    deployment
3. **Configure Infrastructure** - Follow [ADR 010: Infrastructure as
    Code](../operations/010-configmgmt.md) for reproducible data
    infrastructure
4. **Setup Database** - Follow [ADR 018: Database
    Patterns](../operations/018-database-patterns.md) for Aurora
    Serverless v2 as data warehouse

### Security & Operations

1. **Configure Secrets Management** - Follow [ADR 005: Secrets
    Management](../security/005-secrets-management.md) for data source
    credentials and API keys
2. **Setup Logging** - Follow [ADR 007: Centralized Security
    Logging](../operations/007-logging.md) for transformation audit
    trails
3. **Setup Backup Strategy** - Follow [ADR 014: Object Storage
    Backups](../operations/014-object-backup.md) for data warehouse
    backup
4. **Data Governance** - Follow [ADR 015: Data Governance
    Standards](../operations/015-data-governance.md) for SQLMesh data
    contracts and lineage

### Development Process

1. **Configure CI/CD** - Follow [ADR 004: CI/CD Quality
    Assurance](../development/004-cicd.md) for automated testing of
    data transformations
2. **Setup Release Process** - Follow [ADR 009: Release Documentation
    Standards](../development/009-release.md) for SQLMesh model
    versioning
3. **Analytics Tools** - Follow [ADR 017: Analytics Tooling
    Standards](../operations/017-analytics-tooling.md) for Quarto and
    Evidence BI integration

### Implementation Details

**Data Processing & Quality:**

- Configure SQLMesh for data transformation and orchestration  
- Setup S3 object storage for data files and Aurora for metadata
- Implement data quality validation rules and testing frameworks
- Configure DuckDB/DuckLake or Iceberg/Trino based on existing data lake
  alignment

**Cost Optimization & Performance:**

- Configure Aurora Serverless v2 autoscaling for cost-effective metadata
  storage
- Implement S3 lifecycle policies for data archival (Intelligent Tiering
  → Glacier)
- Setup DuckDB for cost-effective analytics vs Athena for large-scale
  queries
- Configure SQLMesh incremental processing to minimize compute costs

**Data Governance & API Access:**

- Setup data API following [ADR 003: API Documentation
  Standards](../development/003-apis.md)
- Implement PII handling, data classification, and retention policies
  per [ADR 015: Data Governance
  Standards](../operations/015-data-governance.md)
- Configure data lineage tracking and impact analysis through SQLMesh
- Setup automated data profiling and anomaly detection
