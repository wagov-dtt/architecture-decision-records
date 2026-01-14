# ADR 017: Analytics Tooling Standards

**Status:** Proposed | **Date:** 2025-07-28

## Context

Organisations need simple, secure reporting with reproducible outputs. Reports should be version-controlled alongside the data transformations that produce them.

- [Quarto Documentation](https://quarto.org/)
- [Government Digital Service Design Standards](https://www.dta.gov.au/help-and-advice/about-digital-service-standard)

## Decision

Use [Quarto](https://quarto.org/) for analytics and reporting.

### Why Quarto

- **Multi-format**: Same source produces HTML, PDF, Word, presentations
- **Version-controlled**: Reports live alongside data transformation code in git
- **Open source**: Markdown-based, portable, no vendor lock-in
- **Accessible**: Built-in support for WCAG compliance

### Capabilities

| Need | Quarto Feature |
|------|----------------|
| Static reports | [Markdown + code blocks](https://quarto.org/docs/authoring/markdown-basics.html) |
| PDF documents | [PDF output](https://quarto.org/docs/output-formats/pdf-basics.html) with professional formatting |
| Interactive charts | [Observable JS](https://quarto.org/docs/interactive/ojs/) for client-side interactivity |
| Dashboards | [Quarto Dashboards](https://quarto.org/docs/dashboards/) for layout and filtering |
| Parameterised reports | [Parameters](https://quarto.org/docs/computations/parameters.html) for automated report generation |

### Integration

- **Data Sources**: Query via [Ibis](https://ibis-project.org/) or DuckDB per [ADR 018: Database Patterns](018-database-patterns.md)
- **Deployment**: Static HTML hosted per [ADR 016: Web Application Edge Protection](../security/016-edge-protection.md)
- **CI/CD**: Automated report generation per [ADR 004: CI/CD Quality Assurance](../development/004-cicd.md)

## Consequences

**Benefits:**

- Version-controlled, reproducible analytics outputs
- Static hosting with minimal operational overhead
- Consistent tooling across reports, dashboards, and documents

**Risks if not implemented:**

- Inconsistent reporting approaches across teams
- Reports not tracked in version control
- Difficulty reproducing historical analytics outputs
