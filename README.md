# Architecture Decision Records

Architecture Decision Records (ADRs) for Office of Digital Government (DGOV) Digital Transformation and Technology Unit (DTT) infrastructure and platform operations.

**Quick Start:** [Open in Codespaces](https://codespaces.new/wagov-dtt/architecture-decision-records) → `just next-number` → Create ADR → `just validate` → Submit PR

## 📁 Current ADRs

**Development (3):** API standards, CI/CD security, release documentation  
**Operations (5):** AWS EKS, logging, Infrastructure as Code (IaC), config management, backups  
**Security (4):** Application isolation, secrets management, Artificial Intelligence (AI) governance

[📖 **View Full Documentation**](https://wagov-dtt.github.io/architecture-decision-records/) | [📄 **Download PDF**](https://github.com/wagov-dtt/architecture-decision-records/releases/latest)

## 🚀 Quick Reference

### Creating ADRs
```bash
just next-number          # Get next ADR number
just validate            # Check format and quality  
just serve              # Preview website locally
just clean              # Remove generated files
```

### ADR Template
```markdown
---
title: "ADR 015: Your Decision Title"
date: 2025-07-22
status: Proposed
tags: [#category, #technology]
---

## Context
What problem are we solving?

## Decision  
What did we decide and why?

## Consequences
What are the trade-offs and risks?
```

## 📋 Title Examples

**✅ Good:** "ADR 015: Adopt container registry scanning", "ADR 016: Use GitOps for deployments"  
**❌ Bad:** "Database stuff", "Security improvements", "Frontend updates"

## 🛠️ Development Commands

| Command | Purpose |
|---------|---------|
| `just next-number` | Get next ADR number to use |
| `just validate` | Check format and prose quality |
| `just serve` | Preview website locally |
| `just build` | Generate final website/PDF |
| `just clean` | Remove generated files |

See [CONTRIBUTING.md](CONTRIBUTING.md) for complete workflow and quality standards.

## 🚀 Automated Deployment

**Website:** Auto-deploys to GitHub Pages on every push to `main`  
**PDF Releases:** Auto-attached to GitHub releases when published

### Manual Deployment
```bash
just build    # Build website and PDF locally
```

## 📚 Related Resources

- [Architecture Principles](./architecture-principles.md) - Guide all decisions
- [DGOV DevSecOps Training](https://soc.cyber.wa.gov.au/training/devsecops-induction/) - Supporting material
- [WA Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy) - Compliance framework
