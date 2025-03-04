---
title: Architecture Principles
date: 2025-03-04
status: Proposed
tags:
- #architecture
- #principles
---

# Architecture Principles (Proposed)

## For all systems and services:

1.  **Security by design**

    1.  Integrate security practices throughout the development lifecycle, not as an afterthought, reference: [ACSC Secure-by-Design](https://www.cyber.gov.au/resources-business-and-government/governance-and-user-education/secure-by-design)

        -   Software executing on servers (such as Websites, API's) will be constructed to meet the [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/) v4+ standard to ASVS Level 2. 

        -   Software executing on clients (such as Mobile Applications) will be constructed to meet the [OWASP MASVS](https://mas.owasp.org) v2+ standard to MAS-L1. 

    2.  Ensure service providers meet the [Minimum Viable Secure Product](https://mvsp.dev) baseline, and additional security controls from the [WA Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy) if needed by the organisations risk assessment.

2.  **Privacy by design**

    1.  Embed privacy protections into the design and architecture of IT systems and business practices from the outset, not as an afterthought, reference [OAIC Privacy by design](https://www.oaic.gov.au/privacy/privacy-guidance-for-organisations-and-government-agencies/privacy-impact-assessments/privacy-by-design) and [WA Privacy and Responsible Information Sharing](https://www.wa.gov.au/government/privacy-and-responsible-information-sharing).

3.  **Data Classification and Handling**

    1.  Classify information based on sensitivity and implement appropriate handling procedures throughout the data lifecycle, reference [WA Information Classification Policy](https://www.wa.gov.au/government/publications/western-australian-information-classification-policy)

4.  **Align investment to risk and market capabilities**

    1.  Systematically migrate legacy systems to modern, low-risk environments with reduced technical debt, prioritising based on business value and risk assessment, reference [ACSC Managing the Risks of Legacy IT: Executive Guidance](https://www.cyber.gov.au/resources-business-and-government/maintaining-devices-and-systems/system-hardening-and-administration/legacy-it-management/managing-risks-legacy-it-executive-guidance)

    2.  Re-use or acquire systems where existing or commercial options closely match business needs

    3.  Develop systems where commercial options are limited or would require significant tailoring to meet business needs

5.  **Adopt [CNCF Cloud-native](https://github.com/cncf/toc/blob/main/DEFINITION.md) practices**

    1.  Architect loosely coupled systems that interoperate in a manner that is secure, resilient, manageable, sustainable, and observable. 

    2.  Use automation and the above practices to enable your organization to make high-impact changes frequently, predictably, with minimal toil and clear separation of concerns.

## For organisation developed systems:

1.  **Ownership and Open Source Licencing**

    1.  Retain ownership of code and artifacts developed with public funding and use the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0) to enable broad use, modification, and distribution while limiting legal liability.

2.  **Microservices architecture**

    1.  Design applications as collections of loosely coupled, independently deployable services, reference [Microservices Patterns](https://microservices.io/patterns/index.html) and [security/001-isolation.md](security/001-isolation.md)

    2.  Develop and document APIs according to the [OpenAPI Specification](https://spec.openapis.org/oas/latest.html "https://spec.openapis.org/oas/latest.html") to ensure consistency, clarity, and interoperability, reference [development/003-apis.md](development/003-apis.md).

4.  **Continuous Integration & Delivery**

    1.  Package applications and dependencies into containers for consistency and portability, and enforce release quality and build attestation with CI/CD, reference [development/004-cicd.md](development/004-cicd.md).