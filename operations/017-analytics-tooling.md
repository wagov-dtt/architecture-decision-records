# ADR 017: Analytics Tooling Standards

**Status:** Proposed | **Date:** 2025-07-28

## Context

Organisations need simple, secure reporting that avoids complex
JavaScript toolchains. Static reports reduce maintenance and security
overhead.

- [Quarto Documentation](https://quarto.org/)
- [Evidence BI Documentation](https://evidence.dev/)
- [Government Digital Service Design
  Standards](https://www.dta.gov.au/help-and-advice/about-digital-service-standard)

## Decision

Use Quarto for static reporting with Evidence BI for high-interactivity
cases only.

### Primary: Quarto Framework

- **Static Reports**:
  [Markdown-based](https://quarto.org/docs/authoring/markdown-basics.html)
  with embedded visualizations
- **Multi-format**: [HTML, PDF
  outputs](https://quarto.org/docs/output-formats/html-basics.html) from
  single source
- **Git Integration**: Reports alongside code in version control
- **Compliance Ready**:
  [Accessibility](https://quarto.org/docs/authoring/) and professional
  formatting

### Secondary: [Evidence BI](https://evidence.dev/)

- **Limited Use**: Only useful for interactive drilldown reporting
  (simpler to host than e.g. PowerBI)
- **SQL-based**: Minimal JavaScript complexity

### Integration

- **Data Sources**: Connect via [ADR 018: Database
  Patterns](018-database-patterns.md)
- **Deployment**: Use [ADR 016: Web Application Edge
  Protection](../security/016-edge-protection.md) for secure
  distribution

## Consequences

**Benefits:**

- Static reports with minimal operational maintenance overhead
- Enhanced security posture with reduced attack surface
- Version-controlled analytics ensuring reproducible results

**Risks if not implemented:**

- High operational overhead maintaining dynamic dashboard infrastructure
- Security vulnerabilities from complex interactive analytics platforms
- Inconsistent analytics outputs affecting decision making
