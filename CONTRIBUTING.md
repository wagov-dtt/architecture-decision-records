# Contributing to Architecture Decision Records

## 🚀 Quick Start

1. **Setup**: Open repository in GitHub Codespaces or VS Code with devcontainer
2. **Get number**: Run `just next-number` to find next ADR number
3. **Create file**: Make new file in appropriate directory using pattern `NNN-short-name.md`
4. **Use template**: Copy template below and replace all placeholders
5. **Validate**: Run `just validate` to check format and prose quality
6. **Preview**: Run `just serve` to see website preview
7. **Update list**: Add your ADR to README.md in appropriate section
8. **Submit**: Create PR with your changes

## 📁 Directory Guide

Choose directory based on primary focus:

- **development/** - Code quality, APIs, testing, CI/CD, build processes, AI usage
- **operations/** - Infrastructure, deployments, monitoring, backups, configuration management  
- **security/** - Access controls, compliance, isolation policies, secrets management

## ✅ Quality Checklist

Before submitting, ensure your ADR has:

- [ ] Action-oriented title starting with verb (Adopt, Use, Enforce, Ensure, Implement)
- [ ] Specific, concrete technology/approach mentioned in title
- [ ] Context section explaining problem with authoritative references  
- [ ] Decision section with bullet-pointed implementation requirements
- [ ] Consequences starting with "**Risks of not implementing:**"
- [ ] Relevant tags (#security, #infrastructure, #development, etc.)
- [ ] No template placeholders remaining
- [ ] Passes `just validate` without errors

## 📋 Template

```markdown
---
title: NNN. [Action Verb] [Specific Technology/Approach]
date: YYYY-MM-DD
status: Proposed
tags:
- #category
- #technology
---

## Status

Proposed

## Context

[Specific problem statement with business/technical context]

- [Authoritative Reference 1](link)
- [Authoritative Reference 2](link)

## Decision

[Clear statement of chosen approach with specific requirements:]

- Requirement 1 with specific implementation detail
- Requirement 2 with configuration specifics
- Requirement 3 with monitoring/validation approach

## Consequences

**Risks of not implementing:**
- Specific negative outcome 1
- Specific negative outcome 2
- Compliance/security risk
- Operational difficulty
```

## 🎯 Title Examples

**Good titles (action + specific tech/approach):**
- ✅ "Use API Gateway for external access"
- ✅ "Enforce CI/CD prechecks and build attestation"  
- ✅ "Adopt EKS auto mode for workloads"
- ✅ "Implement backup strategy with object storage"

**Bad titles (generic/vague):**
- ❌ "Database problems"
- ❌ "Security issues" 
- ❌ "Frontend updates"
- ❌ "Configuration changes"

## 🛠️ Development Commands

```bash
# Essential workflow
just next-number      # Get next ADR number to use
just validate         # Full validation (format + prose + quality)
just serve           # Preview website locally

# Quick checks  
just validate-format  # Fast frontmatter validation only
just validate-prose   # Writing style and clarity check
just build           # Generate final website/PDF
```

## 🔧 Troubleshooting

**Command not found**: Run `eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"`  
**Validation errors**: Check frontmatter format matches template exactly  
**Preview not loading**: Ensure port 8080 is forwarded in your development environment  
**Generic warnings**: Use specific technology names and action verbs in titles
