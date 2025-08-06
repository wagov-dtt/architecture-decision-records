# Reference Architecture: OpenAPI Backend

**Status:** Proposed | **Date:** 2025-07-28

## When to Use This Pattern

Use when you need clear separation between user-facing and
administrative operations in REST APIs requiring structured
documentation and testing.

## Overview

Template for implementing OpenAPI-first API services with complete
separation between user-facing and administrative operations.

## Core Components

API Clients -> Edge Protection -> Routing

Routing -> Standard APIs: api.domain
Routing -> Admin APIs: admin.domain

Standard APIs: {
  style: {
    fill: "#e3f2fd"
    stroke: "#1565c0"
  }
}

Admin APIs: {
  style: {
    fill: "#ffebee"
    stroke: "#c62828"
  }
}

Standard APIs -> User Database
Admin APIs -> System Database
Admin APIs -> User Database: admin access
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
Standards](../security/013-identity-federation.md).

## Project Kickoff Steps

1. **Infrastructure Foundation** - Follow [ADR 001: Application
    Isolation](../security/001-isolation.md) and [ADR 002: AWS EKS for
    Cloud Workloads](../operations/002-workloads.md)
2. **API Standards** - Follow [ADR 003: API Documentation
    Standards](../development/003-apis.md) for OpenAPI specification
3. **Identity Federation** - Follow [ADR 013: Identity Federation
    Standards](../security/013-identity-federation.md) for domain
    separation
4. **Edge Protection** - Follow [ADR 016: Web Application Edge
    Protection](../security/016-edge-protection.md) for rate limiting
    and security
5. **Database & Secrets** - Follow [ADR 018: Database
    Patterns](../operations/018-database-patterns.md) and [ADR 005:
    Secrets Management](../security/005-secrets-management.md)
6. **Logging & Monitoring** - Follow [ADR 007: Centralized Security
    Logging](../operations/007-logging.md) for audit trails
