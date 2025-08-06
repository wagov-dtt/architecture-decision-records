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

Environment Setup -> Content Creation -> Validation -> Publication

Environment Setup: {
  Codespace
  Git Clone
  Tool Setup
}

Content Creation: {
  Get ADR Number
  Choose Template
  Write Content
}

Validation: {
  Lint Check
  Build Test
  Link Validation
}

Publication: {
  Update SUMMARY.md
  Create PR
  Review & Merge
}
publication.create-pr -> publication.peer-review: PR submitted
publication.peer-review -> publication.merge: approval received
publication.merge: Deploy to GitHub Pages

# Feedback Loops
publication.peer-review -> creation.write-content: revision needed
validation.build-test -> creation.write-content: fix issues
quality-gates.standards -> creation.write-content: improve clarity
quality-gates.references -> validation.link-validation: update links
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

See [templates/adr-template.md](templates/adr-template.md) for the complete template.

**Status Options:**
- `Accepted` - Decision is final and implemented
- `Proposed` - Under review or discussion
- `Rejected` - Decision was declined
- `Superseded` - Replaced by newer ADR

**Note**: ADR numbers are globally unique across all directories (gaps from removed drafts are normal)

## Reference Architecture Template

See [templates/reference-architecture-template.md](templates/reference-architecture-template.md) for the complete template.

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
- **Character usage**: Use plain-text safe Unicode - avoid emoji, smart quotes (""),  
  em-dashes (—), and complex symbols for PDF compatibility
- **Terminology**: Use Australian English ("organisation" not "organization") and "jurisdiction" instead of  
  "government" for broad applicability
- **D2 diagrams**: Use D2 format for diagrams with clean syntax and universal compatibility
  - Use when text alone isn't sufficient (system relationships, data flows, workflows)
  - Keep simple: 5-7 components max, clear labels, logical flow, consistent colors

## Reference Architecture Guidelines

**Purpose**: Project kickoff templates that combine existing ADRs

**Rules**:
- Link to existing ADRs only (don't create new ones)
- Keep steps focused (9-11 maximum)
- Include architecture diagram
- Use "jurisdiction" not "government" for broad applicability
