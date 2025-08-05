---
title: 'Reference Architecture: OpenAPI Backend'
date: 2025-07-28T00:00:00.000Z
status: Proposed
tags:
  - reference
  - api
  - openapi
---


**Status:** Proposed \| **Date:** 2025-07-28

## When to Use This Pattern

Use when you need clear separation between user-facing and
administrative operations in REST APIs requiring structured
documentation and testing.

## Overview

Template for implementing OpenAPI-first API services with complete
separation between user-facing and administrative operations.

## Core Components

``` mermaid
graph TB
    Clients[API Clients] --> Edge[Edge Protection]
    Edge --> StandardRouter[Standard Router]
    Edge --> AdminRouter[Admin Router]
    
    StandardRealm[Standard Realm] --> StandardRouter
    AdminRealm[Admin Realm] --> AdminRouter
    
    subgraph EKS[AWS EKS Cluster]
        StandardRouter --> StandardAPI[Standard APIs<br/>api.domain/api/v1/*]
        AdminRouter --> AdminAPI[Admin APIs<br/>admin.domain/admin/v1/*]
    end
    
    StandardAPI --> UserData[User Data]
    AdminAPI --> SensitiveData[Sensitive / Global Data]
```

## API Design Pattern

**Standard APIs** (`/api/v1/*`): Business operations for authenticated
users

- Examples: `/api/v1/users/profile`, `/api/v1/orders`,
  `/api/v1/documents`
- Domain: `api.domain` with Standard Realm authentication

**Administrative APIs** (`/admin/v1/*`): System management for
privileged users

- Examples: `/admin/v1/users`, `/admin/v1/system/config`,
  `/admin/v1/audit-logs`
- Domain: `admin.domain` with Admin Realm authentication

**Complete Separation**: Two separate routers provide full network and
authentication isolation between standard and administrative operations
per [ADR 013: Identity Federation
Standards](../security/013-identity-federation.qmd).

## Project Kickoff Steps

1.  **Infrastructure Foundation** - Follow [ADR 001: Application
    Isolation](../security/001-isolation.qmd) and [ADR 002: AWS EKS for
    Cloud Workloads](../operations/002-workloads.qmd)
2.  **API Standards** - Follow [ADR 003: API Documentation
    Standards](../development/003-apis.qmd) for OpenAPI specification
3.  **Identity Federation** - Follow [ADR 013: Identity Federation
    Standards](../security/013-identity-federation.qmd) for domain
    separation
4.  **Edge Protection** - Follow [ADR 016: Web Application Edge
    Protection](../security/016-edge-protection.qmd) for rate limiting
    and security
5.  **Database & Secrets** - Follow [ADR 018: Database
    Patterns](../operations/018-database-patterns.qmd) and [ADR 005:
    Secrets Management](../security/005-secrets-management.qmd)
6.  **Logging & Monitoring** - Follow [ADR 007: Centralized Security
    Logging](../operations/007-logging.qmd) for audit trails
