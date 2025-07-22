# Contributing Guide

## 🚀 Quick Workflow

1. **Open in Codespaces** → Automatic tool setup
2. **Get number** → `just next-number` 
3. **Create file** → `###-short-name.md` in correct directory
4. **Write content** → Follow template below
5. **Validate** → `just validate` and fix issues
6. **Submit PR** → Ready for review

## 📁 Directory Structure

| Directory | Content |
|-----------|---------|
| `development/` | API standards, CI/CD, releases |
| `operations/` | Infrastructure, logging, config |
| `security/` | Isolation, secrets, AI governance |

## 📝 ADR Template

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

## ✅ Quality Standards

**Before submitting:**
- [ ] Title is specific and actionable
- [ ] All acronyms defined on first use
- [ ] Active voice (not passive)
- [ ] Passes `just validate` without errors

**Title Examples:**
- ✅ "Use AWS EKS for container orchestration"  
- ✅ "Require MFA for production access"
- ❌ "Container stuff" or "Security improvements"

## 🛠️ Commands

```bash
just next-number      # Get next ADR number
just validate        # Check format + prose quality
just serve          # Preview website locally
just clean          # Remove generated files
```

## 📋 Status Guide

| Status | Meaning |
|--------|---------|
| `Proposed` | Under review |
| `Accepted` | Active decision |
| `Superseded` | Replaced by newer ADR |

## 🎯 Writing Tips

- **Be specific**: "Use Redis 7.x" not "Use caching"
- **Include implementation**: How, not just what
- **Define scope**: What's included and excluded
- **Reference standards**: Link to external docs
