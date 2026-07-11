# ADR 002: Managed Kubernetes for Compatible Workloads

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

## Synopsis

- **Use when:** A compatible containerised bespoke workload has a justified need
  for Kubernetes scheduling, scaling, or ecosystem capabilities.
- **Avoid when:** The workload needs unsupported host privileges, specialist
  hardware, unvalidated state semantics, unavailable regional capabilities, or
  disproportionate platform overhead.
- **Decision:** Use managed Kubernetes with provider-managed compute only for
  validated compatible workloads, while preferring simpler supported hosting
  when it meets the need.
- **Required evidence:** Workload-fit, security, region, recovery, support, cost,
  exit, performance, resilience, scaling, and recovery assessments and tests.
- **Dependencies:** [ADR 018: Managed Relational Databases and Open
  Lakehouses](018-database-patterns.md) for durable database state, [ADR 019:
  Shared File Access](019-shared-file-access.md) for shared file state, and
  Proposed [ADR 021: Workload mTLS and Service
  Authorisation](../security/021-workload-mtls.md) when relying on the preferred
  workload-security profile.

## Context

WA public-sector estates span multiple clouds and legacy or on-premises
platforms. Kubernetes can provide a consistent orchestration API for suitable
bespoke software, but it adds cost and operational complexity and does not by
itself make a workload portable.

- [CNCF Certified Kubernetes conformance](https://www.cncf.io/training/certification/software-conformance/)
- [ACSC Guidelines for Cloud Security](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-cloud-security)

## Decision

Use a managed Kubernetes service with provider-managed compute as the default
Kubernetes pattern only for compatible, containerised bespoke workloads. Do
not use Kubernetes as the default hosting model for every application.

A workload is a suitable candidate when it can use supported containers,
standard health and lifecycle controls, externalised durable state, and the
service's networking and identity model. The team must also have a justified
need for Kubernetes scheduling, scaling, or ecosystem capabilities.

Prefer a simpler managed application, container, function, database, virtual
machine, or existing supported platform when it meets the service need.

### Exclusions

Do not select this pattern without an approved exception for:

- Commercial or legacy software that requires certified hosts, privileged
  access, unsupported kernels, fixed appliances, or in-place administration
- Workloads requiring mainframe integration, specialist hardware, disconnected
  operation, or latency that the managed service cannot meet
- Stateful software whose locking, storage, clustering, recovery, or licensing
  requirements have not been validated on the target service
- Small or stable services for which cluster and platform overhead is not
  proportionate
- Workloads whose required service, support tier, data location, or dependency
  is unavailable in an approved region

Keep durable state in an appropriate managed data service or tested shared
file service. See [ADR 018](018-database-patterns.md) and [ADR 019](019-shared-file-access.md).

Production application traffic crossing workload boundaries must use authenticated
workload identity, encryption in transit, and explicit service authorisation where
the platform supports them. Proposed [ADR 021: Workload mTLS and Service
Authorisation](../security/021-workload-mtls.md) defines the preferred Linkerd
implementation profile; a project must approve that Proposed dependency before
relying on it. Validate sidecar, protocol, probe, capacity, and managed-compute
compatibility during the workload-fit assessment.

### Provider Options

These are implementation options, not interchangeable mandates:

| Provider | Managed-compute option | Selection notes |
|---|---|---|
| AWS | [Amazon EKS Auto Mode](https://docs.aws.amazon.com/eks/latest/userguide/automode.html) | Validate supported instance, networking, storage, add-on, and Australian-region capabilities |
| Azure | [AKS Automatic](https://learn.microsoft.com/en-us/azure/aks/intro-aks-automatic) | Validate feature, policy, networking, identity, and region support |
| Google Cloud | [GKE Autopilot](https://cloud.google.com/kubernetes-engine/docs/concepts/autopilot-overview) | Validate workload restrictions, resource model, add-ons, and region support |

For legacy or on-premises estates, retain an existing supported platform when
migration has no service or risk benefit. A new self-managed Kubernetes
platform requires a costed operating model for upgrades, security, recovery,
capacity, and 24-hour support appropriate to service criticality.

### Required Evidence

- Workload-fit assessment covering the exclusions, data classification,
  dependencies, availability, recovery, support, and team capability
- Region and feature availability, security assessment, and provider shared
  responsibility review
- Total-cost comparison including platform labour, observability, networking,
  support, data transfer, and minimum or idle capacity
- Exit assessment identifying provider-specific dependencies, portable images
  and manifests, data extraction, target platform, time, cost, and a tested
  redeployment or recovery path
- Performance, resilience, scaling, and recovery test results before production
- Service-flow, workload identity, encryption, and authorisation assessment, plus
  mesh compatibility where the project adopts proposed ADR 021

### Exceptions

Record a time-bound exception when an excluded workload must use this pattern
or when a compatible workload cannot use managed compute. Include the reason,
alternatives, compensating controls, residual risk, owner, approval, expiry,
and reassessment date.

## Consequences

**Benefits:** managed infrastructure reduces routine node operations while
standard Kubernetes APIs support common deployment practices.

**Trade-offs:** managed modes impose feature constraints, retain provider
dependencies, and may cost more than simpler hosting or an existing platform.
