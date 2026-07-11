# Proposed Decision Backlog

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

This backlog tracks guidance that is useful but not yet accepted as an active
decision. Use it during annual reviews and planning to decide whether each
item should move to `Accepted`, stay `Proposed`, or become `Superseded`.

## Proposed ADRs

| Document | Current status | Next review | Review focus |
|----------|----------------|-------------|--------------|
| [ADR 006: Policy Enforcement](operations/006-policy-enforcement.md) | Proposed | 2027-07-11 | Validate preventive controls, default-deny networking, protective DNS, evidence, and enforcement boundaries |
| [ADR 021: Workload mTLS](security/021-workload-mtls.md) | Proposed | 2027-07-11 | Validate Linkerd compatibility across supported Kubernetes services, staged default-deny policy, certificate operations, observability, performance, and rollback |

## Proposed Reference Architectures

| Document | Current status | Next review | Review focus |
|----------|----------------|-------------|--------------|
| [AI-Assisted Digital Services](reference-architectures/ai-assisted-digital-services.md) | Proposed | 2027-07-11 | Pilot low-risk and bounded variants; validate evaluation, human fallback, data handling, accessibility, operations, cost, and provider exit |
| [Federated Application Portal](reference-architectures/federated-application-portal.md) | Proposed | 2027-07-11 | Validate selectable shared capabilities, cross-agency governance, direct-access fallback, compatibility, resilience, onboarding, and offboarding |
| [Identity Federation](reference-architectures/identity-management.md) | Proposed | 2027-07-11 | Validate direct OIDC, justified broker, privileged, and legacy variants; test claims, recovery, accessibility, rollover, migration, and exit |

## Acceptance Criteria

Move a proposed item to `Accepted` when:

- The scope and non-goals are clear enough for delivery teams to apply
- Required related ADRs are linked
- Implementation steps are practical and testable
- Mandatory statements trace to Accepted ADRs or authoritative policy
- Proposed dependencies are accepted, removed, optional, or explicitly labelled
- Minimum, higher-assurance, and legacy-transition variants have representative
  agency validation
- Provider examples remain non-normative and cover realistic cloud, SaaS, and
  legacy contexts where relevant
- Required artifacts, ownership, accessibility, data handling, operations,
  resilience, migration, and exit checks are complete
- Compliance mapping is complete where relevant
- A reviewer confirms the technology and policy assumptions still hold
- The annual `Review` date is set one year after the document `Date`

Keep a proposed item as `Proposed` when the guidance is directionally useful
but still depends on technology, policy, or operating-model confirmation.

Move a proposed item to `Superseded` when another ADR or reference
architecture has replaced it.
