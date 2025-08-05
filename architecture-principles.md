# Architecture Principles

**Status:** Accepted | **Date:** 2025-03-07

## 1. Establish secure foundations

Integrate security practices **from the outset**, and throughout the design, development and deployment of products and services, per the [ACSC Foundations for modern defensible architecture](https://www.cyber.gov.au/resources-business-and-government/governance-and-user-education/modern-defensible-architecture/foundations-modern-defensible-architecture).

## 2. Understand and govern data

Use authoritative data sources to ensure data consistency, integrity, and quality. Embed data management and governance practices, including [information classification](https://www.wa.gov.au/government/publications/western-australian-information-classification-policy), records management, and [Privacy and Responsible Information Sharing](https://www.wa.gov.au/government/privacy-and-responsible-information-sharing), throughout information lifecycles.

## 3. Prioritise user experience

Apply user-centered design principles to simplify tasks and establish intuitive mappings between user intentions and system responses. Involve users throughout design and development to iteratively evaluate and refine product goals and requirements.

## 4. Preference tried and tested approaches

Adopt sustainable [opensource](https://opensource.org/osd) software, and mature managed services where capabilities closely match business needs. When necessary, bespoke service development should be **led by internal technical capabilities** to ensure appropriate risk ownership. Bespoke software should **preference open standards and code** to avoid vendor lock-in.

## 5. Embrace change, release early, release often

Design services as **loosely coupled** modules with **clear boundaries and responsibilities**. Release often with tight feedback loops to test assumptions, learn, and iterate. Enable frequent and predictable high-impact changes (your service does not deliver or add value until it is in the hands of users) per the [CNCF Cloud Native Definition](https://github.com/cncf/toc/blob/main/DEFINITION.md).

## 6. Default to open

Encourage transparency, inclusivity, adaptability, collaboration, and community by defaulting to [permissive licensing](https://www.apache.org/licenses/LICENSE-2.0) of code and artifacts developed with public funding.
