# ADR 019: Shared File Access

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

## Context

Applications may need object access, file paths, NFS or SMB protocols, or
specific file-system semantics. Treating an object-backed adapter as a general
network file system can cause corruption or incompatibility, while copying data
between object and file stores creates synchronisation and ownership risk.

## Decision

Choose between an object-backed file adapter and a true managed NFS or SMB file
service using tested application semantics.

Use an object-backed adapter when object storage is the canonical source, the
application tolerates the adapter's consistency and metadata model, and testing
confirms its file-operation, concurrency, latency, and failure behaviour. This
can suit media, static assets, exchange areas, and batch or AI/ML datasets.

Use a managed file service when software requires documented POSIX or Windows
semantics, file or byte-range locking, atomic operations, in-place writes,
stable low-latency metadata, protocol-specific ACLs, or vendor-certified NFS or
SMB storage. Keep a file service as the canonical source unless a tested
synchronisation design defines otherwise.

### Provider Options

These products are not exact equivalents. Protocol versions, POSIX behaviour,
locking, identity and ACL models, consistency, quotas, performance, Kubernetes
drivers, regional availability, and object interoperability differ.

| Provider | Object-backed file option | True managed file-service option |
|---|---|---|
| AWS | [Amazon S3 Files](https://aws.amazon.com/s3/features/files/) | [Amazon EFS](https://docs.aws.amazon.com/efs/latest/ug/whatisefs.html) for NFS or [Amazon FSx for Windows File Server](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/what-is.html) for SMB |
| Azure | [NFS 3.0 support for Azure Blob Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/network-file-system-protocol-support) | [Azure Files](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-introduction) for supported SMB or NFS use cases |
| Google Cloud | [Cloud Storage FUSE](https://cloud.google.com/storage/docs/cloud-storage-fuse/overview) | [Filestore](https://cloud.google.com/filestore/docs/overview) for managed NFS |

Legacy or on-premises file services may remain when supported and when their
security, availability, capacity, backup, and recovery controls meet the
service need.

### Validation Requirements

Test representative clients and concurrent workloads for open, create, close,
append, overwrite, rename, delete, directory listing, locking, atomicity,
consistency, links where required, permissions, case handling, file names,
large and small files, throughput, metadata latency, disconnect and retry,
capacity limits, and backup or restore behaviour.

Define the canonical store, owner, access boundary, lifecycle, retention,
recovery objectives, and public-delivery path. Use workload identity and least
privilege. Publish public assets through an approved CDN and edge control under
[ADR 016](../security/016-edge-protection.md).

Snapshots, replication, synchronisation, and object versioning are recovery or
availability features, not automatically independent backups. Immutability can
protect a retained copy but does not create one. Apply [ADR 014](014-object-backup.md)
to both object-backed and managed file stores.

### Migration

Inventory required semantics, permissions, ownership, metadata, links, sizes,
and access patterns before selecting a target. Pilot representative workloads,
copy with checksums and count reconciliation, preserve required metadata,
freeze or control writes for cutover, run application acceptance and recovery
tests, and retain a documented rollback path. Avoid uncontrolled dual writes.

## Required Evidence

- Decision record identifying canonical storage and why the tested adapter or
  file service meets application semantics and provider or region constraints
- Functional, concurrency, reconnect, performance, capacity, and recovery test
  results from representative clients
- Access, encryption, audit, lifecycle, retention, data-location, RTO, RPO, and
  independent-backup configuration and restore evidence
- Migration inventory, checksum and count reconciliation, acceptance, rollback,
  and source decommission or retention records

## Exceptions

Untested semantics, dual canonical stores, unsupported protocols, or missing
independent backup require a time-bound exception with compensating controls,
residual risk, owner, approval, expiry date, and reassessment date.

## Consequences

**Benefits:** evidence-based selection avoids assuming object and file semantics
are interchangeable and reduces unnecessary duplication.

**Trade-offs:** testing and migration take effort, and true file semantics can
reduce object interoperability or increase cost.
