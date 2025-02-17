---
title: Implement CI/CD and QA to sign build artifacts (containers and software) before release
date: 2025-02-17
status: Proposed
tags:
- #ci/cd
- #security
- #containers
---

## Status

Proposed

## Context

The goal is to ensure the security and integrity of containerised applications throughout the development lifecycle. Threat actors exploit vulnerabilities in container images, misconfigurations, and exposed secrets.

- [ACSC Guidelines for Software Development](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development)

## Decision

To address these risks, implement a CI/CD pipeline with the following standardised practices (or similar equivalents) before releasing code and build artifacts (i.e. below should indicate low risk prior to a release being tagged and published for deployment to real (non-development) infrastructure):

- Use GitHub Actions for CI/CD to **automate building and signing of container images**, and Justfiles to manage development tasks.
- **Sign container images** with Cosign to ensure integrity and authenticity.
- Integrate Trivy for **vulnerability scanning of container images**.
- Use Checkov to **identify misconfigurations and exposed secrets**.
- Implement Semgrep for **static code analysis** to find common issues.
- Use Playwright for **end-to-end testing of web applications**.
- Employ Grafana K6 for **API testing to ensure performance and reliability**.
- Align development practices to [ACSC guidelines for software development](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development).

## Consequences

If we do not implement these practices, we risk:

- Deploying containers with known vulnerabilities that can be exploited by attackers.
- Exposing sensitive information due to misconfigurations or hardcoded secrets.
- Compromising the integrity and reliability of our applications due to inadequate testing.
- Non-compliance with legislated requirements, leading to potential legal and reputational risks.

By adopting the above baseline for our CI/CD approach, we enhance the security posture of our containerised applications, ensure compliance with best practices, and maintain high-quality software delivery.