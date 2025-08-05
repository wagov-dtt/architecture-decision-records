---
title: 'ADR 007: Centralised Security Logging'
date: 2025-02-25T00:00:00.000Z
status: Accepted
tags:
  - logging
  - aws
  - sentinel
  - infrastructure
---


**Status:** Accepted \| **Date:** 2025-02-25

## Context

Security logs should be centrally collected to support monitoring,
detection, and response capabilities across workloads. Sensitive
information logging must minimize to follow data protection regulations
and reduce the risk of data breaches. Audit and authentication logs are
critical for security monitoring and should collect by default.

- [Open Web Application Security Project (OWASP) Logging Cheat
  Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html)
- [Australian Cyber Security Centre (ACSC) Guidelines for system
  monitoring](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-system-monitoring)
- [DGOV Technical Baseline for Detection Coverage (MITRE
  ATT&CK)](https://soc.cyber.wa.gov.au/baselines/data-sources/)

## Decision

Use centralized logging using [Microsoft
Sentinel](https://soc.cyber.wa.gov.au/onboarding/sentinel-guidance/) and
[Amazon
CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html).

- Configure default collection for audit and authentication logs to
  simplify security investigations.
- Container workloads should configure [Container insights with enhanced
  observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/deploy-container-insights-EKS.html) +
  [EKS control plane
  logging](https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)
  of audit and authentication logs by default.
- Logging should configure to avoid capturing and exposing Personally
  Identifiable Information (PII).
- Review and update logging configurations to ensure coverage and
  privacy requirements meet.
- Log information used during an investigation should extract and
  archive to an appropriate location (in alignment with record keeping
  requirements).

## Consequences

Risks of not implementing:

- Decentralized logs may lead to delayed detection and response to
  security incidents.
- Increased risk of sensitive information exposure leading to potential
  data breaches and non-compliance with regulations.
- Incomplete audit trails may hinder forensic investigations and
  compliance audits.

Benefits:

- Improved incident detection and response times.
- Simplified compliance with data protection regulations.
- Centralized management of security logs, reducing operational
  overhead.
