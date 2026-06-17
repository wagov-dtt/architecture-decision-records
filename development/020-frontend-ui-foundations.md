# ADR 020: Frontend UI Foundations

**Status:** Proposed | **Date:** 2026-06-17 | **Review:** 2027-06-17

## Context

WA Government digital services need accessible, consistent web interfaces
across public sites, portals, CMS templates, preview tools, widgets, and staff
applications. Teams also need UI patterns that work with agency design systems,
third-party widgets, and independently delivered applications.

Bootstrap 5 is a mature frontend toolkit with documented layout, forms,
components, helpers, utilities, and accessibility guidance. It gives teams a
shared vocabulary for common web UI while still allowing agency design systems
to theme, wrap, or extend components.

## Decision

Use semantic HTML and Bootstrap 5-compatible component conventions as the
default frontend foundation for WA Government digital service web interfaces.

This means teams should:

- Start with semantic HTML, accessible names, keyboard support, and progressive
  enhancement
- Meet WCAG 2.2 AA for user-facing interfaces
- Use Bootstrap 5-compatible layout, forms, navigation, alerts, modals, tables,
  cards, and utilities where common components are needed
- Implement agency design systems as themes, wrappers, or extensions over this
  baseline where practical
- Scope CSS and JavaScript so shared components work safely in CMS templates,
  portals, embedded apps, and third-party widget contexts
- Keep design-system styling separate from business logic and service APIs

Teams may use another component library or native platform design system when
it better fits the product. Record the reason in the project decision log.

## Recommended Starting Points

| Use case | Start with |
|----------|------------|
| Public site, CMS template, or static preview | Bootstrap 5-compatible theme and semantic HTML |
| Technical documentation or review preview | Hugo with a Bootstrap-compatible theme such as Docsy |
| CMS content preview or review pack | Hugo static build fed by file export, read-only feed, or content adapter |
| Drupal-backed content platform | Drupal Bootstrap 5 theme or an agency theme aligned to Bootstrap 5 conventions |
| Portal shell, account widget, inbox widget, or SDK UI | Small scoped Bootstrap-compatible components |
| Staff tool or admin interface | Bootstrap-compatible forms, tables, alerts, and navigation |

## Hugo for Preview and Review Workflows

Use [Hugo](https://gohugo.io/) when a simple, reliable static site generator is
enough for previews, documentation, or review packs. Hugo works well for local
builds, modular themes, and generated static outputs.

Use [Hugo content
adapters](https://gohugo.io/content-management/content-adapters/) to create
pages from existing content libraries or read-only exports such as JSON, TOML,
YAML, or XML. This lets teams build CMS-aligned previews without changing the
CMS workflow first.

[Docsy](https://www.docsy.dev/) is a useful Hugo reference theme for technical
documentation and review sites. Use it as a starting point or comparison for
modular Hugo structure, not as a mandatory theme.

## Accessibility Expectations

Bootstrap helps with accessible component patterns, but accessibility still
depends on correct markup, content, colour choices, scripting, and testing.
Projects must test the finished interface against WCAG 2.2 AA, including:

- Keyboard operation and visible focus
- Colour contrast and non-colour cues
- Accessible names, labels, and error messages
- Heading, landmark, table, and form structure
- Reduced-motion behaviour where animation is used
- Screen-reader behaviour for dynamic components such as modals, alerts, and
  menus

## Consequences

**Benefits:**

- Gives teams a clear default for common web UI
- Improves portability across CMS, portal, preview, and standalone tool contexts
- Supports accessible, semantic, progressively enhanced interfaces
- Reduces bespoke component maintenance
- Keeps agency design systems compatible with a widely understood component
  model

**Trade-offs:**

- Agency themes still need accessibility and brand review
- Some products will need documented alternatives for native, highly bespoke, or
  specialist user interfaces
- Bootstrap-compatible conventions reduce variation but do not remove the need
  for user research, content design, or usability testing

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
