# Quick Reference for ADR Contributors

## 📁 Directory Guide
- **development/** - Code, APIs, testing, CI/CD, build processes
- **operations/** - Infrastructure, deployments, monitoring, backups  
- **security/** - Controls, compliance, isolation, access policies

## ✅ Quality Checklist
- [ ] Title starts with action verb (Adopt, Use, Enforce, Ensure)
- [ ] Context explains problem with authoritative references
- [ ] Decision has specific implementation requirements
- [ ] Consequences start with "Risks of not implementing"
- [ ] Tags include relevant hashtags (#security, #infrastructure, etc.)

## 🚀 Quick Commands
```bash
just next-number     # Get next ADR number
just validate        # Full validation check
just validate-format # Quick frontmatter check
just serve          # Preview website
```

## 📋 Template Checklist
```markdown
---
title: NNN. [Action Verb] [Specific Technology/Approach]
date: YYYY-MM-DD
status: Proposed
tags: [#category, #technology]
---

## Status
Proposed

## Context
[Problem statement + authoritative references]

## Decision  
[Specific requirements with bullet points]

## Consequences
**Risks of not implementing:**
[Clear negative outcomes]
```

## 🎯 Good Title Examples
- ✅ "Use API Gateway for external access"
- ✅ "Enforce CI/CD prechecks and attestation"
- ✅ "Adopt EKS auto mode for workloads"
- ❌ "Database problems"
- ❌ "Security issues"
- ❌ "Frontend updates"
