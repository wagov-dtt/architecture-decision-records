# ADR 015: Data Pipeline Contracts, Quality and Lineage

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

## Context

Data pipelines need explicit interfaces, measurable quality, and evidence of
what actually ran. Source history describes intended transformations but does
not prove runtime lineage or that failed records were handled.

- [Australian Government Data Governance Framework](https://www.finance.gov.au/government/public-data/public-data-policy/data-governance-framework)
- [Reference Architecture: Data Pipelines](../reference-architectures/data-pipelines.md)

## Decision

Implement versioned data contracts, quality controls, and runtime lineage for
production data pipelines. The requirements are independent of transformation,
catalogue, cloud, and query-engine choices.

### Pipeline Requirements

- Define contracts for input and output schema, types, meaning, owner,
  compatibility, keys, freshness, and expected delivery behaviour
- Set approved, measurable thresholds for completeness, validity, uniqueness,
  referential integrity, timeliness, and volume where relevant; identify which
  failures warn, quarantine data, or stop publication
- Capture runtime lineage from authoritative inputs through each executed job
  to published outputs, including run identifier, code and contract version,
  parameters, timestamps, and source or snapshot identifiers
- Treat Git history as design evidence, not a substitute for runtime lineage
- Quarantine or dead-letter invalid records without silently dropping them;
  preserve reason codes, counts, secure access, retry or replay paths, owner
  alerts, and reconciliation to accepted, rejected, and published totals
- Send pipeline operations and quality events to the controls in
  [ADR 007](007-logging.md), without exposing sensitive record contents

Contracts must have a documented compatibility and consumer-notification
process. Production publication must fail safely when a blocking threshold or
contract check fails.

### Implementation Options

[Ibis](https://ibis-project.org/) expressions are one code-based transformation
and validation example, not a mandated governance or lineage platform.
[Microsoft Purview data governance](https://learn.microsoft.com/en-us/purview/data-governance-overview)
and [Dataplex data lineage](https://cloud.google.com/dataplex/docs/about-data-lineage)
are provider options where they fit the estate. Teams may use other tools that
capture equivalent runtime evidence and interoperable exports.

This ADR does not replace agency controls for information classification,
privacy assessment, records retention and disposal, offshoring, access, or
data-location approval.

## Required Evidence

- Approved, versioned contracts and compatibility or consumer-change records
- Quality rules, thresholds, run results, alerts, quarantined-record counts,
  reconciliation, and replay or disposition records
- Queryable runtime lineage from authoritative source to published output for
  sampled production runs
- Transformation versions, approvals, audit events, and access controls for
  sensitive quality and lineage metadata

## Exceptions

Missing contracts, quality checks, or runtime lineage require a time-bound
record of affected datasets and consumers, compensating reconciliation,
residual risk, owner, approval, expiry, and reassessment date.

## Consequences

**Benefits:** explicit contracts and runtime evidence make data failures
detectable, containable, and traceable across platforms.

**Trade-offs:** thresholds require ownership and tuning, while lineage and
failed-record handling add storage and operational complexity.
