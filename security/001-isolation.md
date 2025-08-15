# ADR 001: Application Isolation

**Status:** Accepted | **Date:** 2025-02-17

## Context

Not isolating applications and environments can lead to significant
security risks. The risk of lateral movement means threats of
vulnerability exposure of a single application can compromise other
applications or the entire environment. This lack of isolation can
enable the spread of malware, unauthorised access, and data breaches.

- [Open Web Application Security Project (OWASP) Application Security
  Verification Standard
  (ASVS)](https://owasp.org/www-project-application-security-verification-standard/)
- [Australian Cyber Security Centre (ACSC) Guidelines for System
  Hardening](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-system-hardening)

## Decision

To mitigate the risks associated with shared environments, all
applications and environments should isolate by default. This isolation
can achieve through the following approaches:

1. **Dedicated Accounts**: Use separate cloud accounts / resource
    groups for different environments (for example, development,
    testing, production) to ensure complete isolation of resources and
    data.
2. **Kubernetes Clusters**: Deploy separate Kubernetes clusters for
    different applications or environments to isolate workloads and
    manage resources independently.
3. **Kubernetes Namespaces**: Within a Kubernetes cluster, use
    namespaces to logically separate different applications or
    environments, providing a level of isolation for network traffic,
    resource quotas, and access controls.

The preferred approach for isolation should drive by data sensitivity
and product boundaries.

## Consequences

**Benefits:**

- Network microsegmentation preventing lateral movement
- Simplified incident containment and forensic analysis
- Compliance with regulatory isolation requirements

**Risks if not implemented:**

- Single vulnerability compromising multiple applications
- Difficult incident response across shared environments
- Data breaches through unauthorised cross-system access
