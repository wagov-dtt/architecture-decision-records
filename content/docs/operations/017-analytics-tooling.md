---
title: "ADR 017: Analytics Tooling Standards"
description: "Use simple, secure analytics tooling with reproducible reports version-controlled alongside their transformations."
url: "/operations/017-analytics-tooling.html"
aliases:
  - "/docs/operations/017-analytics-tooling/"
  - "/operations/017-analytics-tooling/"
weight: 170
toc: true
---

## ADR 017: Analytics Tooling Standards

**Status:** Proposed | **Date:** 2025-07-28

### Context

Organisations need simple, secure reporting with reproducible outputs. Reports should be version-controlled alongside the data transformations that produce them.

- [Quarto Documentation](https://quarto.org/)
- [Government Digital Service Design Standards](https://www.dta.gov.au/help-and-advice/about-digital-service-standard)

### Decision

Use [Quarto](https://quarto.org/) for analytics and reporting.

#### Why Quarto

- **Multi-format**: Same source produces HTML, PDF, Word, presentations
- **Version-controlled**: Reports live alongside data transformation code in git
- **Open source**: Markdown-based, portable, no vendor lock-in
- **Accessible**: Built-in support for WCAG compliance

#### Capabilities

| Need | Quarto Feature |
|------|----------------|
| Static reports | [Markdown + code blocks](https://quarto.org/authoring/markdown-basics.html) |
| PDF documents | [PDF output](https://quarto.org/output-formats/pdf-basics.html) with professional formatting |
| Interactive charts | [Observable JS](https://quarto.org/interactive/ojs/) for client-side interactivity |
| Dashboards | [Quarto Dashboards](https://quarto.org/dashboards/) for layout and filtering |
| Parameterised reports | [Parameters](https://quarto.org/computations/parameters.html) for automated report generation |

#### Integration

- **Data Sources**: Query via [Ibis](https://ibis-project.org/) or
  DuckDB per [ADR 018: Database Patterns](/operations/018-database-patterns.html) and
  [Reference Architecture: Data
  Pipelines](/reference-architectures/data-pipelines.html)
- **Deployment**: Static HTML hosted per [ADR 016: Web Application Edge Protection](/security/016-edge-protection.html)
- **CI/CD**: Automated report generation per [ADR 004: CI/CD Quality Assurance](/development/004-cicd.html)

### Consequences

**Benefits:**

- Version-controlled, reproducible analytics outputs
- Static hosting with minimal operational overhead
- Consistent tooling across reports, dashboards, and documents

**Risks if not implemented:**

- Inconsistent reporting approaches across teams
- Reports not tracked in version control
- Difficulty reproducing historical analytics outputs
