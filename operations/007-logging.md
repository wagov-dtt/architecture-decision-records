---
title: Collect relevant security logs into centralised SIEM tooling, and minimise logging of sensitive information.
date: 2025-02-25
status: Proposed
tags:
- #logging
- #aws
- #sentinel
- #infrastructure
---

## Status

Proposed

## Context

Security logs should be centrally collected to support monitoring, detection, and response capabilities across workloads. Sensitive information logging must be minimized to comply with data protection regulations and reduce the risk of data breaches. Audit and authentication logs are critical for security monitoring and should be collected by default.

- [OWASP Logging Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html)
- [ACSC Guidelines for system monitoring](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-system-monitoring)
- [DGOV Technical Baseline for Detection Coverage (MITRE ATT&CK)](https://soc.cyber.wa.gov.au/baselines/data-sources/)

## Decision

Implement centralized logging using [Microsoft Sentinel](https://soc.cyber.wa.gov.au/onboarding/sentinel-guidance/) and [Amazon CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html).

- Configure default collection for audit and authentication logs to simplify security investigations.
- Container workloads should have [Container insights with enhanced observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/deploy-container-insights-EKS.html) + [EKS control plane logging](https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) of audit and authentication logs by default.
- Regularly review and update logging configurations.

## Consequences

Risks of not implementing:

- Decentralized logs may lead to delayed detection and response to security incidents.
- Increased risk of sensitive information exposure leading to potential data breaches and non-compliance with regulations.
- Incomplete audit trails may hinder forensic investigations and compliance audits.

Benefits:

- Improved incident detection and response times.
- Simplified compliance with data protection regulations.
- Centralized management of security logs, reducing operational overhead.