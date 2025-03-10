---
title: Enforce release quality with CI/CD prechecks and build attestation
date: 2025-03-10
status: Proposed
tags:
- #ci/cd
- #security
- #containers
---

## Status

Proposed

## Context

The goal is to ensure the security and integrity of containerised applications throughout the development lifecycle. Threat actors exploit vulnerabilities in code, software dependencies, build tooling, container images, misconfigurations, and exposed secrets.

- [OWASP CI/CD Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/CI_CD_Security_Cheat_Sheet.html)
- [ACSC Guidelines for Software Development](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development)

## Decision

To address these risks, implement a CI/CD pipeline with the following standardised practices (or similar equivalents) before releasing code and build artifacts:

- Use [GitHub Actions](https://docs.github.com/en/actions/about-github-actions/understanding-github-actions) for CI/CD to **automate building and signing of container images**.
- Use [Justfiles](https://just.systems/man/en/) to **manage development tasks**.
- **Sign container images** with [Cosign](https://github.com/sigstore/cosign) to ensure integrity and authenticity.
- Integrate [Trivy](https://trivy.dev/latest/docs/target/container_image/) for **vulnerability scanning of container images**.
- Implement [Semgrep](https://semgrep.dev/docs/getting-started/quickstart) for **static code analysis** to find common issues.
- Use [Playwright](https://playwright.dev/docs/intro) for **end-to-end testing of web applications**.
- Use [Restish](https://rest.sh/#/guide) for **scripted validation of [REST APIs](003-apis.md)**.
- Use [Grafana K6](https://grafana.com/docs/k6/latest/get-started/write-your-first-test/) for **performance and reliability testing**.
- Align development practices to [ACSC guidelines for software development](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development).

Infrastructure as Code (IAC) repos should follow the below standard practices (or similar equivalents) before deploying tagged workloads (indicated as low risk by above) to production environments:

- Use [Justfiles](https://just.systems/man/en/) to **manage operations tasks**.
- Use [kubectl & kustomize](https://kubectl.docs.kubernetes.io/guides/config_management/) for **config management and naming conventions**.
- Use [Checkov](https://www.checkov.io/1.Welcome/What%20is%20Checkov.html) to **identify misconfigurations and exposed secrets**.

## Consequences

If we do not implement these practices, we risk:

- Deploying containers with known vulnerabilities that can be exploited by attackers.
- Exposing sensitive information due to misconfigurations or hardcoded secrets.
- Compromising the integrity and reliability of our applications due to inadequate testing.
- Non-compliance with legislated requirements, leading to potential legal and reputational risks.

By adopting the above baseline for our CI/CD approach, we enhance the security posture of our containerised applications, ensure compliance with best practices, and maintain high-quality software delivery.
