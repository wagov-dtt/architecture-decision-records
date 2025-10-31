# ADR 002: AWS EKS for Cloud Workloads

**Status:** Accepted | **Date:** 2025-02-17

## Context

Organisations want to efficiently manage and scale bespoke workloads in a
secure and scalable manner. Traditional server management can be
cumbersome and inefficient for dynamic workloads. Provider specific
control planes can result in lock-in and artificial constraints limiting
technology options.

- [Cloud Native Computing Foundation (CNCF) Cloud Native
  Landscape](https://landscape.cncf.io/)
- [AWS EKS
  Quickstart](https://docs.aws.amazon.com/eks/latest/userguide/quickstart.html)

## Decision

To address these challenges, use a [CNCF Certified
Kubernetes
platform](https://www.cncf.io/training/certification/software-conformance/#logos)
with automatically managed infrastructure resources. Due to hyperscaler
availability and size [AWS EKS (Elastic Kubernetes
Service)](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
in auto mode is the preferred option. This leverages Kubernetes for orchestration, AWS
EKS for managed Kubernetes services, AWS Elastic Block Store (EBS) for
storage and AWS load balancers for traffic management.

- **AWS EKS Auto Mode**: Provide a managed Kubernetes service, that
  automatically scales the infrastructure based on workload demands.
- **Managed Storage and NodePools**: Ensure that the underlying
  infrastructure is maintained and updated by AWS.
- **Load Balancers**: Standardise ingress and traffic management.

## Consequences

**Benefits:**

- Efficient resource utilisation through managed scaling
- Clear boundaries for shared responsibilities with a small operational overhead
- Enhanced security through automatic updates and patches
- Improved availability with managed storage and node pools

**Risks if not implemented:**

- Resource inefficiency from manual scaling
- High operational overhead managing custom infrastructure
- Security vulnerabilities from delayed updates
- Service downtime during traffic spikes

## Strategic Research

Analysis like [Cloud services and government digital sovereignty in Australia and beyond. / Mitchell, Andrew D.; Samlidis, Theodore.](https://research.monash.edu/en/publications/cloud-services-and-government-digital-sovereignty-in-australia-an/) in the [International Journal of Law and Information Technology, Vol. 29, No. 4, 2021, p. 364-394](https://academic.oup.com/ijlit/issue/29/4) highlights the ongoing issues with depending on hyperscalers in a single country. Based on this changing landscape, exploring simplified options for
secure sovereign owned hosting options such as [Australian Dedicated Servers](https://www.micron21.com/enterprise/dedicated-servers) and [local colo](https://www.hostingcertification.gov.au/certified-service-providers) in Tier 3+ datacentres (designed for 99.98% uptime) is warranted and touched on below.

### Bare metal management

Use a platform like [Proxmox VE](https://www.proxmox.com/en/products/proxmox-virtual-environment/overview) to run standalone clusters at multiple facilities with multiple 2U servers per location. Example hardware (starts approx $15k AUD per server) - [Dell PowerEdge R7725](https://www.dell.com/en-au/shop/cty/pdp/spd/poweredge-r7725), [HPE ProLiant DL385 Gen11](https://www.hpe.com/au/en/hpe-proliant-dl385-gen11.html), [Lenovo ThinkSystem SR665 V3](https://www.lenovo.com/au/en/p/servers-storage/servers/racks/thinksystem-sr665-v3/len21ts0009)

Year 1 estimated costs:
- Hardware: $156,000–$180,000
- Colo (2 sites, Tier 3+): $26,400–$36,000
- Total: $182,400–$216,000 for 1.5TB ram, 288cores across 2 clusters and 30TB disk (3 replicas)