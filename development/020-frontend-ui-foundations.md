# ADR 020: Frontend UI Foundations

**Status:** Proposed | **Date:** 2026-06-17 | **Review:** 2027-06-17

## Context

WA Government digital services need consistent, accessible, maintainable web
interfaces across public websites, portals, CMS templates, preview tools,
widgets, and staff-facing applications. Teams often need to integrate with
existing CMS platforms, third-party widgets, agency design systems, and
independently delivered applications.

Bespoke component systems can create avoidable maintenance burden, accessibility
regressions, lock-in to a frontend framework, and integration problems for CMS
or portal use cases. A mature, standards-based UI foundation helps teams build
quickly while keeping semantic HTML, progressive enhancement, and WCAG 2.2 AA
support visible.

Bootstrap 5 is a mature, widely adopted frontend toolkit with documented layout,
forms, components, helpers, utilities, and accessibility guidance. Its
documentation notes that accessible outcomes still depend on correct author
markup, styling, scripting, and colour choices. This makes Bootstrap a useful
baseline, not a substitute for accessibility testing or design-system review.

## Decision

Prefer semantic HTML and Bootstrap 5-compatible component conventions for WA
Government digital service web interfaces, unless an agency design system or
product constraint requires a documented alternative.

This does not require every service to import Bootstrap directly. A service may
use an agency design system, theme, static-site template, web component, or
framework-specific wrapper where it preserves Bootstrap-compatible structure,
behaviour expectations, and accessibility semantics where practical.

Frontend UI foundations must:

- Start with semantic HTML, accessible names, keyboard support, and progressive
  enhancement
- Meet WCAG 2.2 AA for user-facing interfaces
- Prefer Bootstrap 5-compatible layout, form, navigation, alert, modal, table,
  and utility conventions where a component is needed
- Keep CSS and JavaScript scoped to avoid interfering with CMS editors,
  third-party widgets, portal shells, embedded applications, and preview tools
- Avoid bespoke component libraries unless there is a documented user,
  accessibility, brand, or integration need
- Keep design-system styling separate from business logic and service APIs

## Implementation Guidance

Use Bootstrap 5-compatible conventions as a baseline for:

- CMS templates, static previews, and review tooling
- Portal shells, account widgets, inbox widgets, and SDK-provided UI
- Standalone staff tools, AI review companions, and administrative interfaces
- Static sites, generated reports, and file-review outputs where HTML is used

Agency design systems should wrap or theme the baseline rather than force each
service to create incompatible components. Where a different frontend framework
is used, keep generated HTML and interaction behaviour compatible with the
documented design-system components where practical.

For CMS and review workflows, prefer [Hugo](https://gohugo.io/) where a simple,
reliable static site generator is enough. Hugo provides fast local builds,
modular themes, and [content
adapters](https://gohugo.io/content-management/content-adapters/) that can
dynamically create pages from remote or file-based data sources such as JSON,
TOML, YAML, or XML. This makes it practical to plug preview and review tools
into existing content libraries without requiring deep CMS changes.

[Docsy](https://www.docsy.dev/) is a useful reference implementation for Hugo
technical documentation and preview sites. It is a Hugo theme designed for
technical documentation and uses the Hugo module workflow. Use Docsy as a
reference for modular Hugo site structure, not as a mandatory theme for all
public services.

For Drupal-backed content platforms, the contributed [Bootstrap 5
theme](https://www.drupal.org/project/bootstrap5) is a useful reference for
aligning Drupal theme work with Bootstrap 5 conventions. Drupal project pages
may require browser JavaScript to view, so confirm module status, maintenance,
and compatibility in the normal Drupal review process before adoption.

Do not use this ADR to override agency brand, accessibility, or content design
requirements. Document deviations when another component library, framework,
or native platform design system is a better fit.

## Consequences

**Benefits:**

- Reduces bespoke UI and component maintenance
- Improves portability across CMS, portal, static preview, and standalone tool
  contexts
- Supports accessible, semantic, progressively enhanced interfaces
- Lowers integration risk with third-party widgets and independently owned apps
- Gives teams a clear default without blocking agency-specific design systems

**Risks if not implemented:**

- Inconsistent UI foundations across related services
- Increased accessibility and regression testing burden
- Harder CMS, portal, and widget integration
- More bespoke frontend code to maintain and secure

## Related Reference Architectures

- [AI-Assisted Digital Services](../reference-architectures/ai-assisted-digital-services.md)
- [Content Management](../reference-architectures/content-management.md)
- [Federated Application Portal](../reference-architectures/federated-application-portal.md)

## References

- [Bootstrap 5 documentation](https://getbootstrap.com/docs/5.3/getting-started/introduction/)
- [Bootstrap 5 accessibility guidance](https://getbootstrap.com/docs/5.3/getting-started/accessibility/)
- [Web Content Accessibility Guidelines 2.2](https://www.w3.org/TR/WCAG22/)
- [Hugo content adapters](https://gohugo.io/content-management/content-adapters/)
- [Docsy Hugo theme](https://www.docsy.dev/)
- [Drupal Bootstrap 5 theme](https://www.drupal.org/project/bootstrap5)
