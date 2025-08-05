---
title: 'ADR 011: AI Tool Governance'
date: 2025-07-29T00:00:00.000Z
status: Proposed
tags:
  - development
  - ai
  - security
  - governance
  - isolation
---


**Status:** Proposed \| **Date:** 2025-07-29

## Context

AI tools across all organisational functions process sensitive data and
can make automated decisions affecting security, privacy, and
compliance. Without governance ensuring human oversight of AI decisions,
these tools pose significant risks including unauthorized data exposure,
biased decision-making, and compliance violations. The highest risk
areas are AI tools that process government data or make decisions
without explicit human approval.

Current high-risk scenarios include:

- **Automated Decision-Making**: AI tools making policy, approval, or
  resource allocation decisions without human review
- **Government Data Processing**: Sensitive organisational data
  processed by offshore AI services
- **Uncontrolled AI Outputs**: AI-generated content, code, or analysis
  used without human validation
- **Privacy Violations**: Personal information processed by AI without
  appropriate consent or controls

References:

- [ACSC Information Security Manual
  (ISM)](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)
- [WA Cyber Security
  Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy)
- [Privacy Act 1988](https://www.legislation.gov.au/Series/C2004A03712)

## Decision

Implement mandatory human oversight for all AI tool usage with
pre-approval for any AI tools that process organisational data or
generate outputs used in official capacity.

**Human Oversight Requirements:**

All AI tools must ensure:

- **Human-in-the-Loop**: No automated AI decisions without explicit
  human review and approval
- **Output Validation**: All AI-generated content must be reviewed by
  qualified humans before use
- **Decision Accountability**: Clear human responsibility for all
  AI-assisted decisions
- **Override Capability**: Humans must be able to override or reject AI
  recommendations

**Covered AI Tools:**

- Development and coding assistance tools
- Content generation and writing assistants  
- Data analysis and business intelligence platforms
- Decision support and recommendation systems
- Customer service and communication chatbots
- Document processing and workflow automation

**Implementation Examples:**

- **Approved**: Independently assured developer tools with mandatory
  code review processes for all AI-generated code
- **Rejected**: Automated HR screening tools that make hiring decisions
  without human review

**Mandatory Isolation Requirements:**

Any approved AI tools must be fully sandboxed with no access to:

- Production credentials or secrets
- Privileged system accounts
- Sensitive data repositories
- Network-privileged environments
- Administrative interfaces

**Technical Implementation:**

- AI tools must run in isolated environments with minimal permissions
- No network access to internal systems or databases
- Separate service accounts with restricted access scopes
- Regular audit of AI tool permissions and data access
- Clear data classification and handling procedures
- Automated detection of credential or sensitive data exposure

## Consequences

**Risks of not implementing:**

- **Unaccountable Decisions**: AI making critical decisions without
  human oversight or review
- **Data Exposure**: Sensitive government data processed by offshore AI
  services
- **Compliance Violations**: Breach of Privacy Act and data sovereignty
  requirements
- **Operational Errors**: Unchecked AI outputs causing incorrect policy
  or technical decisions

**Benefits of implementation:**

- Human accountability for all AI-assisted decisions
- Compliance with privacy and data sovereignty requirements  
- Reduced risk of AI-generated errors affecting operations
- Clear audit trail demonstrating responsible AI usage
