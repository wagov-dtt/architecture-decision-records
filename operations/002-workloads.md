---
title: Adopt AWS EKS auto mode for public cloud workloads
date: 2024-02-17
status: Proposed
tags:
- #containers
- #aws
- #eks
- #infrastructure
---

## Status

Proposed

## Context

The challenge is to efficiently manage and scale bespoke workloads in a secure and scalable manner. Traditional server management can be cumbersome and inefficient, especially for dynamic workloads. Provider specific control planes can result in lock-in and artificial constraints limiting technology options.

- [CNCF Cloud Native Landscape](https://landscape.cncf.io/)
- [AWS EKS Quickstart](https://docs.aws.amazon.com/eks/latest/userguide/quickstart.html)

## Decision

To address these challenges, we propose using a [CNCF Certified Kubernetes platform](https://www.cncf.io/training/certification/software-conformance/#logos) with automatically managed infrastructure resources. Currently due to hyperscaler availability and size this would be [AWS EKS (Elastic Kubernetes Service)](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html) in auto mode. This approach leverages Kubernetes for orchestration, AWS EKS for managed Kubernetes services, AWS EBS for storage and AWS load balancers for traffic management.

- **AWS EKS Auto Mode**: Provides a managed Kubernetes service, that utomatically scales the infrastructure based on workload demands.
- **Managed Storage and NodePools**: Ensures that the underlying infrastructure is maintained and updated by AWS.
- **Load Balancers**: Standardises ingress and traffic management.

## Consequences

If we do not adopt this approach, we risk the following:

- **Inefficient Resource Utilization**: Manual scaling and management can lead to over-provisioning or under-provisioning of resources.
- **Increased Operational Overhead**: Managing bespoke workload tooling or kubernetes clusters and underlying infrastructure manually can be time-consuming and error-prone.
- **Security Risks**: Operating system, network and workload orchestration updates and patches can lead to security vulnerabilities if not managed promptly.
- **Reduced Availability**: Self managing storage and nodepools , the system may not handle traffic spikes effectively, leading to downtime.
