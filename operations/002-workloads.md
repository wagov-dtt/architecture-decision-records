---
title: 'ADR 002: AWS EKS for Cloud Workloads'
date: 2025-02-17T00:00:00.000Z
status: Accepted
tags:
  - containers
  - aws
  - eks
  - infrastructure
---


**Status:** Accepted \| **Date:** 2025-02-17

## Context

The challenge is to efficiently manage and scale bespoke workloads in a
secure and scalable manner. Traditional server management can be
cumbersome and inefficient for dynamic workloads. Provider specific
control planes can result in lock-in and artificial constraints limiting
technology options.

- [Cloud Native Computing Foundation (CNCF) Cloud Native
  Landscape](https://landscape.cncf.io/)
- [AWS EKS
  Quickstart](https://docs.aws.amazon.com/eks/latest/userguide/quickstart.html)

## Decision

To address these challenges, we propose using a [CNCF Certified
Kubernetes
platform](https://www.cncf.io/training/certification/software-conformance/#logos)
with automatically managed infrastructure resources. Due to hyperscaler
availability and size this would be [AWS EKS (Elastic Kubernetes
Service)](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
in auto mode. This approach leverages Kubernetes for orchestration, AWS
EKS for managed Kubernetes services, AWS Elastic Block Store (EBS) for
storage and AWS load balancers for traffic management.

- **AWS EKS Auto Mode**: Provide a managed Kubernetes service, that
  automatically scales the infrastructure based on workload demands.
- **Managed Storage and NodePools**: Ensure that the underlying
  infrastructure is maintained and updated by AWS.
- **Load Balancers**: Standardise ingress and traffic management.

## Consequences

If we do not adopt this approach, we risk the following:

- **Inefficient Resource Usage**: Manual scaling and management can lead
  to over-provisioning or under-provisioning of resources.
- **Increased Operational Overhead**: Managing bespoke workload tooling
  or kubernetes clusters and underlying infrastructure manually can be
  time-consuming and error-prone.
- **Security Risks**: Operating system, network and workload
  orchestration updates and patches can lead to security vulnerabilities
  if not managed.
- **Reduced Availability**: Self managing storage and nodepools , the
  system may not handle traffic spikes, leading to downtime.
