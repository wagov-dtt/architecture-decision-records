# ADR 006: Automated Policy Enforcement

**Status:** Proposed | **Date:** 2026-07-11 | **Review:** 2027-07-11

## Context

Governance must work across AWS, Azure, Google Cloud, and legacy or on-premises
estates. Manual review does not scale, but enabling broad deny policies before
understanding existing resources can disrupt essential services.

## Decision

Implement provider-neutral governance capabilities and map them to the native
controls of each estate. Required capabilities are:

- An organisation hierarchy, landing-zone baseline, approved regions and
  services, accountable ownership, and resource inventory
- Preventive controls for high-risk actions and detective controls with an
  owner and remediation deadline where prevention is not practical
- Version-controlled policy definitions, change review, policy testing, and
  validation in delivery pipelines
- Least privilege, encryption, required metadata, data-location restrictions,
  supported technology versions, and default-deny network boundaries with
  explicitly approved flows
- Approved protective DNS with blocked-request monitoring
- Continuous compliance reporting, drift detection, remediation, and
  time-bound exception handling

### Provider Mapping

| Capability | AWS | Azure | Google Cloud |
|---|---|---|---|
| Landing zone and hierarchy | [AWS Control Tower](https://docs.aws.amazon.com/controltower/latest/userguide/what-is-control-tower.html) | [Azure landing zones](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/) | [Google Cloud landing zones](https://cloud.google.com/architecture/landing-zones) |
| Preventive organisation controls | [Service control policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html) | [Azure Policy](https://learn.microsoft.com/en-us/azure/governance/policy/overview) | [Organization Policy](https://cloud.google.com/resource-manager/docs/organization-policy/overview) |
| Configuration and compliance evidence | [AWS Config](https://docs.aws.amazon.com/config/latest/developerguide/WhatIsConfig.html) | Azure Policy compliance and resource inventory | Organization Policy results and [Cloud Asset Inventory](https://cloud.google.com/asset-inventory/docs/overview) |

Native controls may be supplemented by policy-as-code and configuration tools
for Kubernetes, SaaS, network appliances, servers, and other platforms that are
outside a cloud organisation hierarchy.

For Kubernetes east-west traffic, enforce workload identity, mTLS, and explicit
service authorisation under [ADR 021: Workload mTLS and Service
Authorisation](../security/021-workload-mtls.md). Mesh policy complements
NetworkPolicy and cloud network controls rather than replacing them.

Provision and configure these native organisation controls through the preferred
OpenTofu or Terraform workflow in [ADR 010](010-configmgmt.md) where supported.
The native service remains the enforcement point; the common infrastructure layer
provides consistent review, plans, state, testing, and audit evidence across
providers.

### Network Controls

Transit services centralise routing; they do not automatically authorise or
inspect traffic. Apply route controls, workload firewalls or security groups,
DNS controls, and an inspection service where the risk assessment requires it.
This applies to AWS Transit Gateway, Azure hub or Virtual WAN, Google Cloud
Network Connectivity Center, and equivalent on-premises networks.

[AWS VPC Flow Logs](https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs.html),
[Azure virtual network flow logs](https://learn.microsoft.com/en-us/azure/network-watcher/vnet-flow-logs-overview),
and [Google Cloud VPC Flow Logs](https://cloud.google.com/vpc/docs/flow-logs)
record network-flow metadata subject to each service's scope, aggregation,
sampling, and delivery behaviour. They are not complete packet capture or
proof of all egress. Combine relevant flow logs with firewall, DNS, proxy,
identity, and application telemetry under [ADR 007](007-logging.md).

### Adoption

1. Inventory resources, dependencies, existing exceptions, and policy impact.
2. Deploy new policies in test, dry-run, audit, or detective mode and assign
   remediation owners.
3. Remediate the baseline, then enforce high-confidence controls for new and
   changed resources with tested break-glass and rollback paths.
4. Expand enforcement in risk order and monitor denied actions, false
   positives, coverage gaps, and policy drift.

Emergency access and policy administration must be separated, strongly
authenticated, logged, and regularly tested.

### Required Evidence

- Version-controlled policy definitions, tests, approvals, and deployment
  history
- Current hierarchy, landing-zone, inventory, compliance, and drift reports
- Approved network-flow matrix and evidence from applicable firewall, DNS,
  flow-log, and inspection controls
- Audit-to-enforce results, remediation records, denied-action monitoring, and
  tested break-glass procedures
- Exception records linked to controls that remain non-compliant

### Exceptions

Policy exclusions must be narrowly scoped and time-bound. Record the failed
control, affected resources, compensating controls, residual risk, accountable
owner, executive approval, expiry date, and reassessment date.

## Consequences

**Benefits:** consistent controls reduce preventable misconfiguration and
produce evidence across heterogeneous estates.

**Trade-offs:** staged adoption takes time, native policy semantics differ, and
poorly tested preventive controls can interrupt services.
