# ADR 021: Workload mTLS and Service Authorisation

**Status:** Proposed | **Date:** 2026-07-11 | **Review:** 2027-07-11

## Synopsis

- **Use when:** Protecting production application traffic between workloads on
  supported Kubernetes clusters.
- **Avoid when:** Traffic is outside the supported mesh scope or an existing
  cluster would switch directly to broad deny without flow inventory,
  compatibility testing, rollback, and break-glass preparation.
- **Decision:** Prefer Linkerd for Kubernetes workload identity and mTLS, then
  progress compatible services to explicit default-deny inbound authorisation
  tied to dedicated workload service accounts.
- **Required evidence:** Workload and flow inventory, version-controlled policy,
  positive and negative tests, health and certificate monitoring, and trust,
  performance, upgrade, and rollback records.
- **Dependencies:** [ADR 001: Application Isolation](001-isolation.md), Proposed
  [ADR 006: Automated Policy Enforcement](../operations/006-policy-enforcement.md),
  [ADR 010: Infrastructure and Configuration as
  Code](../operations/010-configmgmt.md), and [ADR 007: Centralised Security
  Logging](../operations/007-logging.md).

## Context

Private network location does not authenticate a workload or authorise a service
call. Kubernetes pod addresses are ephemeral, shared clusters contain multiple
trust boundaries, and network controls alone cannot express service or route
identity reliably.

Internal service traffic needs authenticated workload identity, encryption in
transit, explicit authorisation, and evidence that policy is enforced. Installing a
service mesh is insufficient if plaintext remains accepted or all authenticated
workloads can call every service.

- [Linkerd automatic mTLS](https://linkerd.io/2/features/automatic-mtls/)
- [Linkerd authorization policy](https://linkerd.io/2/features/server-policy/)
- [Linkerd CNI plugin](https://linkerd.io/2/features/cni/)
- [Kubernetes NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policies/)

## Applicability

Apply this ADR to production application traffic between workloads on supported
Kubernetes clusters. Apply it to development and test environments where needed to
validate production identity and policy.

Do not assume this ADR covers:

- Traffic to unmanaged external, SaaS, database, or legacy endpoints
- User authentication or application-level resource authorisation
- UDP, host-network, control-plane, or platform traffic that does not traverse the
  selected mesh
- Confidentiality from either authorised endpoint

System namespaces and third-party workloads should be meshed only after compatibility
and support validation. Non-Kubernetes traffic needs an equivalent approved identity,
mTLS, gateway, or application TLS design.

## Decision

Use [Linkerd](https://linkerd.io/) as the preferred Kubernetes implementation for
authenticated and encrypted service-to-service traffic. It provides a consistent
implementation across Amazon EKS, Azure Kubernetes Service, Google Kubernetes Engine,
and conformant Kubernetes platforms without selecting a provider-specific mesh.

Application namespaces must be meshed by default where compatibility is demonstrated.
Production services must progress to default-deny inbound authorisation based on
authenticated workload identity and explicitly approved traffic flows.

### Workload Identity and mTLS

- Assign a dedicated Kubernetes ServiceAccount to each independently authorised
  workload; do not use the namespace `default` ServiceAccount for applications
- Bind mesh identity to the workload ServiceAccount and keep service identity stable
  across replica, node, and provider changes
- Require mTLS for traffic between meshed workloads and verify it from both traffic
  telemetry and negative tests
- Prevent plaintext access from non-meshed sources once a service enters enforcement
- Prohibit proxy bypass and skipped inbound ports unless documented and approved
- Use fail-closed admission for namespaces that require the mesh so a workload cannot
  start without its proxy; use the Linkerd CNI plugin where supported to avoid
  granting network-administration capability to application pods
- Treat mTLS as workload authentication and transport protection, not as user identity
  or business authorisation

Linkerd automatically uses mTLS between meshed pods, but its permissive defaults can
accept plaintext from non-meshed sources. Each protected service therefore needs an
enforced inbound policy, not only proxy injection.

### Service Authorisation

Define policy from the approved service-flow matrix:

- Identify the destination workload, port, protocol, and route where applicable
- Allow only named source workload identities that need the operation
- Use Linkerd `Server`, `HTTPRoute` or `GRPCRoute`, `MeshTLSAuthentication`, and
  `AuthorizationPolicy` resources as appropriate
- Keep the default closed; do not use broad namespace or cluster authentication where
  specific workload identities are practical
- Authorise health probes, ingress, jobs, operators, and monitoring explicitly where
  their traffic differs from normal service calls
- Test alternate routes, direct pod access, old versions, and non-meshed clients to
  confirm they cannot bypass policy

Ingress traffic terminates at an approved gateway or ingress controller. Mesh the
gateway where supported so gateway-to-service traffic uses an authenticated workload
identity. Preserve and validate end-user identity separately at the application.

### Defence in Depth

Linkerd policy complements rather than replaces:

- Default-deny Kubernetes NetworkPolicy under [ADR 001: Application
  Isolation](001-isolation.md)
- Cloud firewalls, routing, protective DNS, and flow controls under [ADR 006:
  Automated Policy Enforcement](../operations/006-policy-enforcement.md)
- Application authentication, operation and resource authorisation, and input
  validation
- TLS appropriate to external endpoints and protocols outside the mesh

NetworkPolicy limits reachable network paths. Mesh policy authenticates workload
identity and authorises service traffic. Both are required for production application
boundaries unless an approved equivalent control applies.

### Trust and Certificate Operations

- Scope trust anchors to the smallest practical administrative and security domain;
  do not share a trust anchor across agencies or unrelated environments by default
- Protect trust-anchor and issuer material separately from application workloads
- Keep private key material out of OpenTofu or Terraform state
- Automate short-lived workload certificate issuance and issuer rotation, monitor all
  expiry dates, and test rollover before production
- Require an explicit trust, routing, failure, incident, and revocation design before
  enabling multi-cluster or non-Kubernetes mesh expansion
- Run the Linkerd control plane in its supported high-availability configuration for
  production, configure proxy injection to fail closed for protected namespaces, and
  test loss or degradation of control-plane and admission components

### Policy Delivery and Observability

- Provision the cluster add-on and supporting infrastructure through OpenTofu or
  Terraform under [ADR 010](../operations/010-configmgmt.md), using pinned and reviewed
  Linkerd and chart versions
- Keep workload injection, identity, server, route, authentication, and authorisation
  policy in version control with the owning platform or application configuration
- Validate policy in CI/CD and prevent production deployment of an application that
  should be meshed but lacks a proxy or required policy
- Export policy denials, proxy health, mTLS coverage, identity and certificate health,
  and service metrics to the monitoring controls in [ADR 007](../operations/007-logging.md)
- Do not enable retries, timeouts, or traffic shifting globally without application
  testing; mesh and application retry behaviour can multiply load and failures

## Adoption

1. Inventory service flows, ServiceAccounts, protocols, probes, ingress, jobs, and
   known direct or external clients.
2. Deploy Linkerd in a non-production cluster, validate protocol compatibility,
   capacity, latency, failure behaviour, proxy injection, and certificate operations.
3. Mesh selected namespaces and observe traffic before changing authorisation.
4. Define policies in audit mode, reconcile unexpected flows, and assign owners.
5. Enforce default-deny policy service by service, starting with new and
   higher-consequence workloads.
6. Validate mTLS and negative access tests, then expand coverage with a monitored
   rollback path.

Do not switch an existing cluster directly from permissive defaults to cluster-wide
deny without a tested flow inventory, probe handling, break-glass path, and staged
rollout.

## Required Evidence

- Workload, ServiceAccount, namespace, and mesh-coverage inventory
- Approved service-flow matrix linked to version-controlled NetworkPolicy and Linkerd
  authorisation policy
- CI/CD checks showing required injection and policy are present
- Positive and negative connectivity tests, including proof that plaintext,
  unauthorised identities, and bypass paths are rejected
- mTLS coverage, policy-denial, proxy-health, and certificate-expiry monitoring
- Trust-anchor ownership, issuer rotation, rollover, recovery, and multi-cluster trust
  records where applicable
- Performance, capacity, upgrade, control-plane failure, and rollback test results

## Exceptions

Unmeshed production application traffic, accepted plaintext, shared workload identity,
broad authenticated access, skipped ports, or an alternative mesh requires a
time-bound exception. Record compatibility constraints, affected flows and data,
equivalent or compensating controls, residual risk, owner, executive approval,
remediation date, expiry, and reassessment date.

## Consequences

**Benefits:** workloads receive provider-neutral identity, automatic mTLS, explicit
service authorisation, consistent telemetry, and policy evidence.

**Trade-offs:** every pod gains a proxy and policy dependency; certificate, control
plane, protocol, capacity, upgrade, and troubleshooting responsibilities increase.
