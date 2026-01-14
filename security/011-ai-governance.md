# ADR 011: AI Tool Governance

**Status:** Accepted | **Date:** 2025-08-15

## Context

Generative AI tool use for development and operation functions process sensitive data and
can make automated decisions affecting security, privacy, and
compliance. Without governance ensuring human oversight of AI decisions,
these tools pose significant risks including unauthorized data exposure,
biased decision-making, and compliance violations. The highest risk
areas are AI tools that process sensitive data or make decisions
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
- [WA Government Artificial Intelligence Policy and Assurance Framework](https://www.wa.gov.au/government/publications/wa-government-artificial-intelligence-policy-and-assurance-framework)
- [Linux Foundation Agentic AI Foundation](https://www.linuxfoundation.org/press/linux-foundation-announces-the-formation-of-the-agentic-ai-foundation)

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

**Covered AI Tools:**

- Development and coding assistance tools
- Content generation and writing assistants
- Data analysis and business intelligence platforms

**Implementation Examples:**

- **Endorsed**: Independently assured developer tooling with human code review processes for all generated code
- **Rejected**: Automated bug fixing tools that merge pull requests or push releases
  without human review

**Mandatory Requirements:**

Any generative AI tools must not:

- Automatically perform actions in customer facing environments or on production infrastructure.
- Process sensitive data with third parties that are not governed by a formal contractual arrangement.
- Automatically merge or release changes without human review and approval.

**Technical Implementation:**

- AI tools must run in isolated or local environments (refer to [ADR 001: Application Isolation](001-isolation.md)) with minimal permissions
- No network access to internal systems or databases
- Technical guardrails to protect against exfiltration and malicious commands

## Strategic Research

The following AI-assisted security tools are under investigation for potential future adoption:

| Tool | Purpose | Status | Links |
|------|---------|--------|-------|
| [ZeroPath](https://zeropath.com/) | AI-powered security code review and vulnerability detection | Under Investigation | [Documentation](https://docs.zeropath.com/) |

These tools are being evaluated for alignment with the human oversight requirements outlined in this ADR. Any adoption will require demonstrated compliance with mandatory requirements above.

## Consequences

**Benefits:**

- Ensures human accountability for all AI-assisted decisions
- Maintains compliance with Privacy Act and data sovereignty requirements
- Prevents automated actions in production environments without approval
- Establishes clear audit trail for responsible AI usage

**Risks if not implemented:**

- Unauthorized data exposure to offshore AI services
- AI making critical decisions without human oversight
- Compliance violations and regulatory breaches
- Operational errors from unchecked AI outputs
