# ADR 015: Data Governance Standards

**Status:** Proposed | **Date:** 2025-07-28

## Context

Data pipelines require governance to ensure quality and compliance. Modern approaches use code-based validation and version control rather than separate governance tools.

- [Ibis Project Documentation](https://ibis-project.org/)
- [Australian Government Data Governance Framework](https://www.finance.gov.au/government/public-data/public-data-policy/data-governance-framework)

## Decision

Use code-based data governance with git workflows. Data transformations
written in [Ibis](https://ibis-project.org/) are version-controlled,
testable, and provide implicit lineage through code dependencies. See
[Reference Architecture: Data
Pipelines](../reference-architectures/data-pipelines.md) for full
implementation patterns.

### Priority Focus Areas

- **Schema Contracts**: Define expected schemas in code, validate in CI/CD pipeline
- **Data Lineage**: Track through transformation code history in git
- **Quality Validation**: Use Ibis expressions for data validation checks, run as automated tests
- **Audit Integration**: Follow [ADR 007: Centralised Security Logging](007-logging.md) for transformation logs

### Implementation

```python
# Example: Schema validation with Ibis
import ibis

def validate_customers(table: ibis.Table) -> ibis.Table:
    """Validate customer data before processing."""
    return table.filter(
        table.email.notnull() &
        table.created_at.notnull() &
        (table.status.isin(['active', 'inactive', 'pending']))
    )
```

## Consequences

**Benefits:**

- Data quality validation as code, testable in CI/CD
- Lineage tracked through git history and code dependencies
- No separate governance infrastructure to maintain

**Risks if not implemented:**

- Data quality issues reaching downstream systems
- Unable to trace data issues back to source transformations
- Compliance gaps from undocumented data handling
