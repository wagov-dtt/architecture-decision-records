# Reference Architecture: OpenAPI Backend

**Status:** Proposed | **Date:** 2025-07-28

## When to Use This Pattern

Use when building:

- Backend services that other applications consume via API
- Systems requiring clear separation between public and administrative operations
- Services needing auto-generated API documentation

## Overview

This template implements OpenAPI-first API services with complete separation between user-facing operations (`api.domain`) and administrative operations (`admin.domain`). The separation provides network and authentication isolation for privileged functions.

## Core Components

```d2
direction: right

clients: API Clients
edge: Edge Protection
api: Standard API
admin: Admin API
db: Database

clients -> edge -> api
clients -> edge -> admin

api -> db: user data
admin -> db: system config
```

**Standard APIs** (`api.example.com/v1/*`): Business operations for authenticated users

**Admin APIs** (`admin.example.com/v1/*`): System management for privileged users

The two endpoints use separate authentication realms per [ADR 013: Identity Federation Standards](../security/013-identity-federation.md), providing network and authentication isolation.

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
