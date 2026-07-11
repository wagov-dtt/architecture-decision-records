# ADR 020: Frontend UI Foundations

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

## Synopsis

- **Use when:** Building or materially changing public or staff-facing websites,
  portals, content-management templates, previews, or embedded web widgets.
- **Avoid when:** The interface is native, an email or document, a specialised
  visualisation, an unchangeable vendor interface, or a functioning legacy
  interface that would be replaced only to adopt a component library.
- **Decision:** Use the applicable government design system first, otherwise use
  semantic HTML and an approved component approach, with WCAG 2.2 AA and user
  research governing outcomes.
- **Required evidence:** Design-system decision, user research, accessibility
  results, browser and device tests, and any approved improvement plan or
  exception.
- **Dependencies:** None.

## Context

WA Government digital services need accessible, consistent web interfaces
across public sites, portals, CMS templates, preview tools, widgets, and staff
applications. Teams also need UI patterns that work with agency design systems,
third-party widgets, and independently delivered applications.

Interfaces must reflect applicable agency standards, use the web platform well, and
be informed by the people who use the service. A component library can support this
work but cannot establish accessibility, usability, or policy compliance by itself.

## Decision

Use the applicable agency or whole-of-government design system as the primary
frontend foundation. Where no design system is mandated, use semantic HTML and an
agency-approved component approach. Bootstrap 5 is an approved fallback option, not
a requirement, where it fits the product and no mandated design system applies.

This means teams should:

- Confirm and apply the relevant design system, brand, content, and digital-service
  requirements before selecting implementation products
- Start with [semantic HTML](https://html.spec.whatwg.org/multipage/dom.html#semantics),
  accessible names, keyboard support, and progressive enhancement
- Meet [WCAG 2.2 AA](https://www.w3.org/TR/WCAG22/) for user-facing web interfaces
- Conduct proportionate user research and usability testing, including people with
  disability and users at risk of digital exclusion where relevant
- Reuse approved accessible components before creating new variants
- Scope CSS and JavaScript so shared components work safely in CMS templates,
  portals, embedded apps, and third-party widget contexts
- Keep design-system styling separate from business logic and service APIs

Record the design-system applicability decision and any approved fallback in the
project decision log.

### Applicability and Non-Goals

This ADR applies to public and staff-facing web interfaces, including sites,
portals, CMS templates, previews, and embedded widgets. Research and assurance depth
should reflect user impact, transaction risk, audience diversity, and change scope.

Native applications should follow the applicable native and agency design system.
Emails, documents, data visualisations, and vendor interfaces that cannot be changed
need their own accessibility controls. This ADR does not mandate visual uniformity,
a JavaScript framework, a static-site generator, or replacement of a functioning
legacy interface solely to adopt a component library.

## Implementation Examples

| Use case | Possible approach where agency-approved |
|----------|-----------------------------------------|
| Public site or CMS template | Applicable agency design system and semantic HTML |
| Site without a mandated design system | Semantic HTML with an approved fallback such as [Bootstrap 5](https://getbootstrap.com/docs/5.3/getting-started/introduction/) |
| Technical documentation or static review | A static-site generator such as [Hugo](https://gohugo.io/), optionally with [Docsy](https://www.docsy.dev/) |
| CMS content preview | Static build fed by a file export, read-only feed, or content adapter |
| Drupal-backed platform | Agency theme or an approved theme such as [Drupal Bootstrap 5](https://www.drupal.org/project/bootstrap5) |
| Portal, widget, or staff tool | Small, scoped components from the applicable design system or approved fallback |

Products in this table are implementation examples, not standards.

### Static Preview Example

[Hugo](https://gohugo.io/) can provide local builds and generated static outputs
when a static site generator is sufficient for previews, documentation, or review
packs.

Its [content adapters](https://gohugo.io/content-management/content-adapters/) can create
pages from existing content libraries or read-only exports such as JSON, TOML,
YAML, or XML. This lets teams build CMS-aligned previews without changing the
CMS workflow first.

[Docsy](https://www.docsy.dev/) is one optional reference theme for technical
documentation and review sites.

## Accessibility Expectations

Design systems and component libraries can help with accessible patterns, but the
finished interface must be tested against WCAG 2.2 AA. Testing should combine
automated checks with keyboard, browser, and assistive-technology review, including:

- Keyboard operation and visible focus
- Colour contrast and non-colour cues
- Accessible names, labels, and error messages
- Heading, landmark, table, and form structure
- Reduced-motion behaviour where animation is used
- Screen-reader behaviour for dynamic components such as modals, alerts, and
  menus

## Required Evidence

- Design-system applicability decision and approval for any fallback
- User-research findings, tested journeys, and resulting design decisions
- Automated and manual accessibility results for representative pages and states
- Component, browser, and device test results proportionate to supported users
- Improvement plan or approved exception for known material gaps

## Exceptions

A deviation from a mandated design system or an unresolved WCAG 2.2 AA issue
requires documented user impact, policy or legal review where applicable,
compensating controls or an accessible alternative, accountable approval, an expiry
date, and a remediation plan. Product limitations alone do not demonstrate
accessibility.

### Legacy Adoption

Legacy services do not need a wholesale redesign. Inventory templates, components,
and critical journeys; fix barriers with the greatest user impact first; and require
new or materially changed interfaces to follow this ADR. Track remaining material
gaps in a prioritised, time-bound improvement plan informed by user feedback.

## Consequences

**Benefits:**

- Gives teams a clear hierarchy for frontend decisions
- Improves portability across CMS, portal, preview, and standalone tool contexts
- Supports accessible, semantic, progressively enhanced interfaces
- Reduces bespoke component maintenance
- Prioritises agency consistency and evidence from users

**Trade-offs:**

- Design-system components still need accessibility and usability review in context
- Some products will need documented alternatives for native, highly bespoke, or
  specialist user interfaces
- Research, content design, and testing require ongoing delivery effort

## Related Reference Architectures

- [AI-Assisted Digital Services](../reference-architectures/ai-assisted-digital-services.md)
- [Content Management](../reference-architectures/content-management.md)
- [Federated Application Portal](../reference-architectures/federated-application-portal.md)

## References

- [Bootstrap 5 documentation](https://getbootstrap.com/docs/5.3/getting-started/introduction/)
- [Bootstrap 5 accessibility guidance](https://getbootstrap.com/docs/5.3/getting-started/accessibility/)
- [Digital Service Standard](https://www.digital.gov.au/policy/digital-experience/digital-service-standard)
- [HTML Standard semantics](https://html.spec.whatwg.org/multipage/dom.html#semantics)
- [Web Content Accessibility Guidelines 2.2](https://www.w3.org/TR/WCAG22/)
- [Hugo content adapters](https://gohugo.io/content-management/content-adapters/)
- [Docsy Hugo theme](https://www.docsy.dev/)
- [Drupal Bootstrap 5 theme](https://www.drupal.org/project/bootstrap5)
