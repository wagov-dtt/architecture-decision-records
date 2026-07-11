# ADR 014: Independent Backups and Recovery

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

## Context

Critical services require recoverable copies of data, software,
configuration, keys, and security information. Geographic replication improves
availability but can copy deletion, corruption, or malicious changes.

- [ACSC Information Security Manual](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)

## Decision

Maintain at least one tested backup copy that is logically and
administratively independent of the production workload. Protect that copy
from alteration or deletion for its approved retention period, including by a
compromised production administrator.

```mermaid
flowchart LR
    service[Production Service] -->|controlled backup| copy[Independent Backup Copy]
    copy -->|tested restore| recovery[Isolated Recovery Environment]
```

Replication, object versioning, snapshots, and database point-in-time recovery
are useful availability or operational-recovery controls. None is a backup by
itself unless the resulting copy has the required failure independence,
retention protection, access separation, monitoring, and tested restore path.
Immutability protects a retained copy; it does not create that copy.

### Required Capabilities

- Coverage of all data and dependencies required for service recovery,
  including application data, file assets, infrastructure and deployment
  configuration, source or releasable artifacts, critical audit records, and
  separately recoverable keys or key procedures
- Encryption in transit and at rest, dedicated backup identities, strong
  authentication, least privilege, and separation of backup and workload
  administration
- Approved retention and disposal, legal or investigation holds, data
  classification and location, and storage separation based on correlated
  failure and jurisdiction risk
- Application-consistent recovery across interdependent stores and a clean,
  isolated restoration path
- Monitoring for backup, copy, retention, capacity, and restoration failures
- Recovery tests that validate service operation and include destructive or
  ransomware scenarios, not only object retrieval

Derive RTOs and RPOs from approved business continuity and service-criticality
assessments. Configure backup frequency, transfer, retention, and restoration
capacity to meet them. Cross-region or off-site copies are required when the
continuity assessment identifies a site or regional failure risk, subject to
approved data-location constraints.

### Immutable Object Options

These controls can protect a backup target and are not complete backup
solutions on their own:

| Provider | Immutable object-storage option |
|---|---|
| AWS | [Amazon S3 Object Lock](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock.html) |
| Azure | [Immutable storage for Azure Blob Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/immutable-storage-overview) |
| Google Cloud | [Cloud Storage Bucket Lock](https://cloud.google.com/storage/docs/bucket-lock) |

Legacy and on-premises implementations may use supported object, appliance,
tape, or offline media where they provide equivalent independence, retention,
inventory, monitoring, and tested recovery.

## Required Evidence

- Backup inventory mapped to services, data owners, classification, RTO, RPO,
  retention, disposal authority, dependencies, and storage locations
- Architecture and configuration showing copy independence, encryption,
  immutable retention, key recovery, and separate administrative access
- Backup and copy success records, failed-job alerts, capacity monitoring, and
  reconciliation showing expected recovery points are present
- At least annual restore and ransomware-recovery test results, and tests after
  material recovery-architecture changes, with measured RTO and recovered RPO

## Exceptions

Where an independent or immutable backup cannot be implemented, record the
missing control, recovery impact, compensating controls, residual risk, owner,
executive approval, expiry date, and reassessment date.

## Consequences

**Benefits:** independent, tested copies reduce correlated failure and
ransomware risk and provide defensible recovery evidence.

**Trade-offs:** protected copies, separate administration, data transfer, and
realistic recovery tests add cost and operational effort.
