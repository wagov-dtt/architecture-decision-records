# ADR 017: Reproducible Analytical Publications

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

## Context

Some analytical outputs combine narrative, code, tables, and charts and need a
reviewable, reproducible publication process. Enterprise BI, operational
dashboards, self-service exploration, and transactional applications have
different governance and interaction needs.

- [Quarto documentation](https://quarto.org/)
- [Australian Government Digital Service Standard](https://www.dta.gov.au/help-and-advice/about-digital-service-standard)

## Decision

Use [Quarto](https://quarto.org/) as the default only for suitable reproducible
analytical publications: outputs built from versioned narrative and code,
generated on a controlled schedule or release, and delivered as HTML,
documents, presentations, or bounded interactive reports.

Do not require Quarto for governed enterprise BI, real-time operational
monitoring, broad self-service analytics, or applications that need row-level
security and interactive workflows. Select an approved BI, dashboard, or
application platform for those needs and document its governance and evidence.

### Publication Requirements

- Pin or record source code, dependencies, build image or environment,
  parameters, and source-data snapshot, query, or release identifier
- Build through reviewed automation, retain the generated artifact and build
  log, and record the source commit and artifact hash
- Keep secrets and classified or personal source data out of repositories,
  build logs, and published artifacts; apply disclosure and small-cell checks
  where relevant
- Test calculations, failed builds, links, rendering, and representative
  historical rebuilds

Quarto provides accessibility authoring features, but it does not make every
output WCAG conformant. Follow the [Quarto HTML accessibility guidance](https://quarto.org/docs/output-formats/html-accessibility.html)
and test the final format against applicable accessibility requirements,
including manual keyboard, screen-reader, structure, colour, and alternative
text checks. PDF and office-document outputs may need separate remediation.

### Publishing Paths

Publish public HTML only through an approved public hosting and edge path under
[ADR 016](../security/016-edge-protection.md). Publish internal, sensitive, or
classified outputs only to an approved access-controlled environment at the
required classification, with identity, audit, retention, download, and
sharing controls. Do not use a public static-hosting path for those outputs.

## Required Evidence

- Suitability decision showing why Quarto or another analytics platform fits
- Source and dependency versions, data identifier, parameters, build logs,
  artifact hash, approvals, and a successful reproducibility test
- Calculation tests, accessibility assessment and remediation, disclosure
  review, and publishing access or classification approval
- Retention and disposal decision for source, build evidence, and publications

## Exceptions

Non-reproducible builds, inaccessible formats, or publication outside the
approved path require a time-bound record of need, audience, compensating
controls, residual risk, owner, approval, expiry, and reassessment date.

## Consequences

**Benefits:** suitable publications are reviewable, portable, and reproducible
without imposing one tool on all analytics.

**Trade-offs:** controlled builds and accessibility testing require effort, and
Quarto does not replace governed BI or secure content-management capabilities.
