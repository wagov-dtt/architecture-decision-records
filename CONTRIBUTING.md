# Contributing Guide

## Quick Workflow

1. **Open in Codespaces** → Automatic tool setup
2. **Get number** → `just next-number`
3. **Create file** → `###-short-name.md` in correct directory
4. **Write content** → Follow template below
5. **Validate** → `just validate` and fix issues
6. **Submit PR** → Ready for review

## Directory Structure

| Directory | Content |
|-----------|---------|
| `development/` | API standards, CI/CD, releases |
| `operations/` | Infrastructure, logging, config |
| `security/` | Isolation, secrets, AI governance |

## ADR Template

```markdown
---
title: "ADR ###: Specific Decision Title"
date: 2025-07-22
status: Proposed
tags: [#category, #technology]
---

## Context
What problem are we solving? Include background and constraints.

## Decision
What we decided and how to implement it:

- **Requirement 1**: Specific implementation detail
- **Requirement 2**: Configuration specifics
- **Requirement 3**: Monitoring approach

## Consequences
**Positive:**
- Benefit 1 with explanation
- Benefit 2 with explanation

**Negative:**
- Risk 1 with mitigation
- Risk 2 with mitigation
```

## Quality Standards

**Before submitting:**

- [ ] Title is concise (under 50 characters) and actionable
- [ ] All acronyms defined on first use
- [ ] Active voice (not passive)
- [ ] Passes `just validate` without errors

**Title Examples:**

- GOOD: "ADR 002: AWS EKS for Cloud Workloads" (concise, ~30 chars)
- GOOD: "ADR 015: Email Authentication Protocols" (specific, clear)
- BAD: "ADR 004: Enforce release quality with CI/CD prechecks and build attestation" (too long)
- BAD: "Container stuff" or "Security improvements" (too vague)

## Commands

```bash
just next-number      # Get next ADR number
just validate        # Check format + prose quality
just serve          # Preview website locally
just clean          # Remove generated files
```

## Status Guide

| Status | Meaning |
|--------|---------|
| `Proposed` | Under review |
| `Accepted` | Active decision |
| `Superseded` | Replaced by newer ADR |

## ADR References

**In frontmatter (for strong relationships):**

```yaml
supersedes: "012"     # This ADR replaces ADR 012
related: ["005", "007"]  # Related to ADRs 005 and 007
```

**In text (for implementation details):**

- Reference format: `[ADR 005: Secrets Management](../security/005-secrets-management.md)`
- Quick reference: `per ADR 005`
- Multiple refs: `aligned with ADR 001 and ADR 005`

**Examples:**

- Implementation: "Encryption handled per [ADR 005: Secrets Management](../security/005-secrets-management.md)"
- Quick mention: "Access controls aligned with ADR 001"
- Multiple: "Following standards from ADR 003 and ADR 009"

## Writing Tips

- **Be specific**: "Use AWS EKS auto mode" not "Use containers"
- **Include implementation**: How, not just what
- **Define scope**: What's included and excluded
- **Reference standards**: Link to external docs
- **Use Australian English**: "organisation" not "organization", "colour" not "color"
