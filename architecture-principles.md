---
title: Architecture Principles
date: 2025-03-07
status: Proposed
tags:
- #architecture
- #principles
---

# Architecture Principles (Proposed)

## 1. Establish secure foundations

Integrate security practices **throughout the development lifecycle**, not as an afterthought, as per the [ACSC Secure-by-Design](https://www.cyber.gov.au/resources-business-and-government/governance-and-user-education/secure-by-design) guidelines.

## 2. Preference tried and tested approaches

Adopt sustainable [opensource](https://opensource.org/osd) software, and mature managed services where capabilities closely match business needs. When necessary, bespoke service development should build on open standards and code led by internal technical capabilities to ensure appropriate governance and avoid lock-in, risk or runaway complexity.

## 3. Understand and govern data

Use authoritative data sources to ensure data consistency, integrity, and quality. Embed data management and governance practices, including [information classification](https://www.wa.gov.au/government/publications/western-australian-information-classification-policy), records management, and [Privacy and Responsible Information Sharing](https://www.wa.gov.au/government/privacy-and-responsible-information-sharing), throughout information lifecycles.

## 4. Embrace change, release early, release often

Design services as **loosely coupled** modules with **clear boundaries and responsibilities**. Release often with tight feedback loops to test assumptions, learn and iterate. Enable frequent and predictable high-impact changes (your service does not deliver or add value until it is in the hands of users) as per the [CNCF Cloud Native Definition](https://github.com/cncf/toc/blob/main/DEFINITION.md).

## 5. Default to open

Encourage transparency, inclusivity, adaptability, collaboration, and community by defaulting to [permissive licensing](https://www.apache.org/licenses/LICENSE-2.0) of code and artifacts developed with public funding.
