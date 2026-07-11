# ADR 007: Centralised Security Logging

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

## Synopsis

- **Use when:** Collecting, retaining, analysing, and operating security
  telemetry from cloud, SaaS, on-premises, or legacy services.
- **Avoid when:** Central forwarding is assumed to replace tested source
  retention, or collection unnecessarily exposes sensitive data.
- **Decision:** Collect and buffer events on source platforms, route
  security-relevant telemetry to the central analysis platform, and use
  risk-based logging profiles, detections, retention, and operating coverage.
- **Required evidence:** Source inventory, logging profiles, detection catalogue,
  parsing and end-to-end test records, access reviews, and tamper-protection
  evidence.
- **Dependencies:** None.

## Context

Security monitoring requires reliable telemetry from cloud and legacy estates
without unnecessarily collecting personal or sensitive information. Collection,
analysis, retention, and operating coverage are separate capabilities.

- [ACSC Guidelines for System Monitoring](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-system-monitoring)
- [WA SOC Technical Baseline for Detection Coverage](https://soc.cyber.wa.gov.au/baselines/data-sources/)

## Decision

Use source-platform logging services to collect and buffer events, then route
security-relevant telemetry to the agency's central analysis platform.
Where WA Government SOC onboarding or agency direction applies, integrate with
the WA SOC and use Microsoft Sentinel in accordance with the
[WA SOC Sentinel guidance](https://soc.cyber.wa.gov.au/onboarding/sentinel-guidance/).

### Source Collection

| Estate | Source collector and operating service |
|---|---|
| AWS | [Amazon CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html), plus relevant service audit, identity, network, and security logs |
| Azure | [Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/fundamentals/overview), plus relevant platform, Entra, network, and security logs |
| Google Cloud | [Cloud Logging](https://cloud.google.com/logging/docs/overview), plus relevant audit, identity, network, and security logs |
| Legacy, on-premises, and SaaS | Supported agents, syslog or CEF relays, Windows event collection, or authenticated APIs through monitored gateways; use applicable [Microsoft Sentinel data connectors](https://learn.microsoft.com/en-us/azure/sentinel/connect-data-sources) |

Do not treat a native collector as the security analytics platform, or central
forwarding as a replacement for source retention, until replay and recovery
have been tested.

### Service Logging Profile

Each service must maintain a risk-based profile that defines:

- Required security, audit, authentication, administrative, network,
  application, control-plane, endpoint, and data-access events
- Source and service owners, parsing and normalisation, time synchronisation,
  collection-health monitoring, and expected event volume
- Detection use cases, triage path, severity, response target, and operating
  coverage, including out-of-hours escalation for critical services
- Searchable and archive retention, retrieval time, records-disposal authority,
  investigation or legal holds, data location, privacy, and access controls

Retention and analyst coverage must follow service criticality, threat and
investigation needs, WA SOC requirements, and agency record-keeping decisions;
one period or operating model is not suitable for every log source.

Minimise personal and sensitive data. Where collection is necessary, restrict
access and retention. Protect critical logs from alteration or deletion and
separate log administration from workload administration.

### Legacy Onboarding

Inventory legacy sources and onboard them in risk order. Start with identity,
privileged access, internet gateways, critical servers, security controls, and
high-value applications. Validate event completeness, timestamps, parsing,
delivery under outage, buffering, duplicate handling, and collection-health
alerts before relying on a source for detection.

Continuously analyse required events in Microsoft Sentinel where mandated,
maintain documented detections and escalation paths, and test priority
detections and WA SOC hand-offs at least annually and after material changes.

## Required Evidence

- Current source inventory, logging profiles, owners, classification,
  retention, operating coverage, and collection-health status
- Detection catalogue mapped to priority threats and critical services
- Parsing and end-to-end event tests, outage or replay tests, alerts, triage,
  escalation, and annual detection-test records
- Access reviews and evidence that protected logs cannot be altered or deleted
  by workload administrators

## Exceptions

Logging, retention, or monitoring gaps require a time-bound risk record naming
affected threats and services, compensating telemetry, residual risk, owner,
executive approval, expiry date, and reassessment date.

## Consequences

**Benefits:** central analysis and tested source collection improve detection,
investigation, and WA SOC coordination.

**Trade-offs:** broad collection can increase cost and privacy exposure, while
legacy sources require engineering and ongoing health monitoring.
