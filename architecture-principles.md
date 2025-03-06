---
title: Architecture Principles
date: 2025-03-04
status: Proposed
tags:
- #architecture
- #principles
---

# Architecture Principles (Proposed)

## 1. Security by Design

Integrate security practices throughout the development lifecycle, not as an afterthought, following the [ACSC Secure-by-Design](https://www.cyber.gov.au/resources-business-and-government/governance-and-user-education/secure-by-design) guidelines. Ensure service providers meet the [Minimum Viable Secure Product](https://mvsp.dev) baseline and additional controls from the [WA Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy) if required by the organisation's risk assessment.

### Threat Modeling

Ensure [Threat Modeling](https://github.com/adamshostack/4QuestionFrame) occurs during system design:

- What are we working on?
- What can go wrong?
- What are we going to do about it?
- How will we measure if we did a good job?

Adopt OWASP technical security controls (below) prioritised by threat models:

- Server software, including APIs, should target [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/) v4+ standard at **ASVS Level 2**.
- Client software, including mobile apps, should target [OWASP MASVS](https://mas.owasp.org) v2+ standard at **MAS-L1**.

## 2. Privacy by Design

Embed privacy protections into the design and architecture of IT systems and business practices from the outset, following [OAIC Privacy by Design](https://www.oaic.gov.au/privacy/privacy-guidance-for-organisations-and-government-agencies/privacy-impact-assessments/privacy-by-design) and [WA Privacy and Responsible Information Sharing](https://www.wa.gov.au/government/privacy-and-responsible-information-sharing) guidelines.

## 3. Data Classification and Handling

Classify information based on sensitivity and implement appropriate handling procedures throughout the data lifecycle, as outlined in the [WA Information Classification Policy](https://www.wa.gov.au/government/publications/western-australian-information-classification-policy).

## 4. Prioritise investments based on risk

Systematically migrate legacy systems to modern, low-risk environments with reduced technical debt, prioritising based on business value and risk assessment, as per [ACSC Managing the Risks of Legacy IT: Executive Guidance](https://www.cyber.gov.au/resources-business-and-government/maintaining-devices-and-systems/system-hardening-and-administration/legacy-it-management/managing-risks-legacy-it-executive-guidance). Re-use or acquire systems where existing or commercial options closely match business needs, and develop systems only when commercial options are limited or require significant tailoring.

## 5. Adopt CNCF Cloud-native practices

Architect loosely coupled systems that interoperate securely, resiliently, manageably, sustainably, and observably. Use automation to enable frequent, high-impact changes with minimal effort and clear separation of concerns.

## 6. Unencumbered re-use and licensing (for bespoke systems)

Retain ownership of code and artifacts developed with public funding and use the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0) to enable broad use, modification, and distribution while limiting legal liability.

## 7. Microservices Architecture (for bespoke systems)

Design applications as collections of loosely coupled, independently deployable services, following [Microservices Patterns](https://microservices.io/patterns/index.html) and [security/001-isolation.md](security/001-isolation.md). Develop and document APIs according to the [OpenAPI Specification](https://spec.openapis.org/oas/latest.html) to ensure consistency, clarity, and interoperability, as per [development/003-apis.md](development/003-apis.md).

## 8. Continuous Integration & Delivery (for bespoke systems)

Package applications and dependencies into containers for consistency and portability, enforcing release quality and build attestation with CI/CD, as per [development/004-cicd.md](development/004-cicd.md).
