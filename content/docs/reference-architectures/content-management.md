---
title: "Reference Architecture: Content Management"
description: "Build content platforms with separated authoring, storage, and delivery using managed databases, object media storage, and CDN/WAF delivery."
url: "/reference-architectures/content-management.html"
aliases:
  - "/docs/reference-architectures/content-management/"
  - "/reference-architectures/content-management/"
weight: 10
toc: true
---

## Reference Architecture: Content Management

**Status:** Proposed | **Date:** 2025-07-28

### When to Use This Pattern

Use when building:

- Public websites and intranets
- Content portals with editorial workflows
- Headless CMS backends for mobile apps or multi-channel publishing

Do not use this pattern for simple static sites that can be generated at
build time without editorial workflows.

### Overview

Build content platforms with a small CMS runtime, managed database,
object-backed media storage, and CDN/WAF delivery. Keep authoring,
storage, and delivery concerns separate so content editors can work
safely while public users only reach cached, protected endpoints.

### Core Components

```mermaid
flowchart LR
    editors["Content Editors"] -->|author + approve| cms["CMS Application"]
    cms -->|content metadata| db["Content Database"]
    cms -->|media assets| media["Object Storage"]
    media -->|origin| cdn["CDN + WAF"]
    cms -->|publish / invalidate| cdn
    cdn -->|deliver| users["End Users"]
```

### Project Kickoff Steps

#### Foundation Setup

1. **Apply Isolation** - Follow [ADR 001: Application
   Isolation](/security/001-isolation.html) for CMS service network,
   runtime, and environment separation
2. **Deploy CMS Runtime** - Follow [ADR 002: AWS EKS for Cloud
   Workloads](/operations/002-workloads.html) for the CMS application and
   background workers
3. **Configure Infrastructure** - Follow [ADR 010: Infrastructure as
   Code](/operations/010-configmgmt.html) for reproducible database,
   storage, CDN, and runtime deployments
4. **Setup Storage** - Follow [ADR 018: Database
   Patterns](/operations/018-database-patterns.html) for the content
   database and [ADR 019: Shared File
   Access](/operations/019-shared-file-access.html) when editorial or
   processing workloads need shared file access to media assets

#### Security & Operations

1. **Configure Secrets Management** - Follow [ADR 005: Secrets
   Management](/security/005-secrets-management.html) for database,
   CMS, identity, and API credentials
2. **Setup Logging** - Follow [ADR 007: Centralised Security
   Logging](/operations/007-logging.html) for audit trails, publishing
   events, and administrative actions
3. **Setup Backup Strategy** - Follow [ADR 014: Object Storage
   Backups](/operations/014-object-backup.html) for content database,
   media asset, and configuration recovery
4. **Configure Edge Protection** - Follow [ADR 016: Web Application
   Edge Protection](/security/016-edge-protection.html) for CDN, WAF,
   origin protection, and cache rules
5. **Identity Integration** - Follow [ADR 013: Identity Federation
   Standards](/security/013-identity-federation.html) and [ADR 012:
   Privileged Remote Access](/security/012-privileged-remote-access.html)
   for editorial and administrative access

#### Implementation Details

**Content Model & Editorial:**

- Define content types, ownership, approval stages, and publishing rules
  before selecting CMS plugins or custom fields
- Use role-based editorial workflows for draft, review, approval, and
  publishing steps
- Keep administrative CMS endpoints separate from public delivery paths
- Implement headless CMS APIs following [ADR 003: API Documentation
  Standards](/development/003-apis.html) where content is consumed by
  other applications

**Media & Delivery:**

- Store media assets in object storage as the source of truth
- Use [ADR 019: Shared File
  Access](/operations/019-shared-file-access.html) only when authoring,
  processing, or migration tools need file-system semantics
- Serve public media through CDN/WAF per [ADR 016: Web Application Edge
  Protection](/security/016-edge-protection.html)
- Configure cache keys, TTLs, and invalidation for publishing workflows

**Compliance & Quality:**

- Test WCAG 2.1 AA accessibility before publishing templates or major
  content changes
- Apply content retention, disposal, and ownership rules per [ADR 015:
  Data Governance Standards](/operations/015-data-governance.html)
- Configure privacy notices, cookie consent, and multilingual content
  where required
- Monitor content performance, broken links, publishing failures, and CDN
  cache effectiveness
