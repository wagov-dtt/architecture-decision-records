# Contributing Guide

## When to Create ADRs

**Create ADRs for foundational decisions only:**

- High cost to change mid/late project
- Architectural patterns and technology standards
- Security frameworks and compliance requirements
- Infrastructure patterns that affect multiple teams

**Don't create ADRs for:**

- Implementation details (use documentation)
- Project-specific configurations
- Operational procedures that change frequently
- Tool-specific guidance that belongs in user manuals

## Quick Workflow

1. **Open in Codespaces** → Automatic tool setup
2. **Get number** → `just next-number`
3. **Create file** → `###-short-name.md` in correct directory ([see content types](#content-types-when-to-use-what))
4. **Write content** → Follow template below
5. **Lint** → `just lint` to fix formatting, check SUMMARY.md, and validate links
6. **Add to SUMMARY.md** → Include new ADR in navigation (required for mdBook)
7. **Submit PR** → Ready for review

**ADR Creation Workflow:**

```text
┌─────────────┐    ┌──────────────┐    ┌─────────────────┐    ┌──────────────┐
│   Setup     │───▶│   Create     │───▶│    Validate     │───▶│   Submit     │
│ Environment │    │   Content    │    │   & Format      │    │     PR       │
└─────────────┘    └──────────────┘    └─────────────────┘    └──────────────┘
      │                    │                      │                     │
      ▼                    ▼                      ▼                     ▼
┌─────────────┐    ┌──────────────┐    ┌─────────────────┐    ┌──────────────┐
│ • Codespace │    │ • Get number │    │ • just lint     │    │ • Add to     │
│ • Clone     │    │ • Template   │    │ • Format/links  │    │   SUMMARY.md │
│ • Tools     │    │ • Directory  │    │ • Build test    │    │ • Review     │
└─────────────┘    └──────────────┘    └─────────────────┘    └──────────────┘
```

## Directory Structure

| Directory | Content |
|-----------|---------|
| `development/` | API standards, CI/CD, releases |
| `operations/` | Infrastructure, logging, config |
| `security/` | Isolation, secrets, AI governance |
| `reference-architectures/` | Project kickoff templates |

## Content Types: When to Use What

### ADRs (Architecture Decision Records)

**Purpose**: Document foundational technology decisions that are expensive to change  
**Format**: `###-decision-name.md` in `development/`, `operations/`, or `security/`  
**Examples**: "AWS EKS for workloads", "Secrets management approach", "API standards"

### Reference Architectures  

**Purpose**: Project kickoff templates that combine multiple existing ADRs  
**Format**: `descriptive-name.md` in `reference-architectures/`  
**Examples**: "Content Management", "Data Pipelines", "Identity Management"

**Rule**: Reference architectures should only link to existing ADRs, not create new ones.

## ADR Template

```markdown
# ADR ###: Specific Decision Title

**Status:** Proposed | **Date:** YYYY-MM-DD

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

**Status Options:**

- `Accepted` - Decision is final and implemented
- `Proposed` - Under review or discussion
- `Rejected` - Decision was declined
- `Superseded` - Replaced by newer ADR

**Note**: ADR numbers are globally unique across all directories (gaps from removed drafts are normal)

## Reference Architecture Template

```markdown
# Reference Architecture: Pattern Name

**Status:** Proposed | **Date:** YYYY-MM-DD

## When to Use This Pattern
Clear use case description for when to apply this architecture.

## Overview
Brief template description focusing on practical implementation.

## Core Components
┌─────────┐    ┌─────────┐    ┌─────────┐
│ Source  │───▶│ Process │───▶│ Output  │
└─────────┘    └─────────┘    └─────────┘

## Project Kickoff Steps

1. **Step Name** - Follow [ADR ###: Title](../category/###-filename.md) for implementation
2. **Next Step** - *ADR needed for missing standards*
3. **Final Step** - Reference to existing practices

```

## Quality Standards

**Before submitting:**

- [ ] Title is concise (under 50 characters) and actionable
- [ ] All acronyms defined on first use
- [ ] Active voice (not passive)
- [ ] Passes `just lint` without errors

**Title Examples:**

- GOOD: "ADR 002: AWS EKS for Cloud Workloads" (concise, ~30 chars)
- GOOD: "ADR 008: Email Authentication Protocols" (specific, clear)
- BAD: "ADR 004: Enforce release quality with CI/CD prechecks and build attestation" (too long)
- BAD: "Container stuff" or "Security improvements" (too vague)

## Commands

Run `just` to see all available commands.

**Quick setup:**

```bash
./scripts/setup.sh   # Automated setup script
```

## Status Guide

| Status | Meaning |
|--------|---------|
| `Proposed` | Under review |
| `Accepted` | Active decision |
| `Superseded` | Replaced by newer ADR |

## ADR References

**Reference format:**

- `[ADR 005: Secrets Management](../security/005-secrets-management.md)`
- Quick reference: `per ADR 005`
- Multiple refs: `aligned with ADR 001 and ADR 005`

**Examples:**

- "Encryption handled per [ADR 005: Secrets Management](security/005-secrets-management.md)"
- "Access controls aligned with ADR 001"

## Writing Tips

- **Be specific**: "Use AWS EKS auto mode" not "Use containers"
- **Include implementation**: How, not just what
- **Define scope**: What's included and excluded
- **Reference standards**: Link to external docs
- **Use Australian English**: "organisation" not "organization", "colour" not "color"
- **Character usage**: Use plain-text safe Unicode (box-drawing ┌─┐ is fine) but avoid emoji, smart quotes (""),  
  em-dashes (—), and complex symbols for PDF compatibility
- **Terminology**: Use Australian English ("organisation" not "organization") and "jurisdiction" instead of  
  "government" for broad applicability
- **ASCII diagrams**: Use box drawing characters (┌─┐│└┘) for universal compatibility

## Reference Architecture Guidelines

**Purpose**: Project kickoff templates that combine existing ADRs

**Rules**:
- Link to existing ADRs only (don't create new ones)
- Keep steps focused (9-11 maximum)
- Include architecture diagram
- Use "jurisdiction" not "government" for broad applicability
