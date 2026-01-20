# ADR 011: AI Tool Governance

**Status:** Accepted | **Date:** 2025-08-15

## Context

Generative AI tools used for development and operations can process
sensitive data and make automated decisions affecting security, privacy,
and compliance. Without governance ensuring human oversight, these tools
pose significant risks including unauthorized data exposure, biased
decision-making, and compliance violations.

High-risk scenarios include:

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
- [WA Government Artificial Intelligence Policy and Assurance
  Framework](https://www.wa.gov.au/government/publications/wa-government-artificial-intelligence-policy-and-assurance-framework)
- [Linux Foundation Agentic AI
  Foundation](https://www.linuxfoundation.org/press/linux-foundation-announces-the-formation-of-the-agentic-ai-foundation)
- [Oxide RFD 576: Using LLMs at
  Oxide](https://rfd.shared.oxide.computer/rfd/0576) - values-based
  approach to AI tool governance

## Decision

Implement mandatory human oversight for all AI tool usage with
pre-approval for any AI tools that process organisational data or
generate outputs used in official capacity.

**Human Oversight Requirements:**

Adopt a values-based approach to AI governance (per [Oxide RFD
576](https://rfd.shared.oxide.computer/rfd/0576)):

- **Responsibility**: Humans bear responsibility for AI-generated
  artifacts - the tool acts at human behest
- **Rigor**: AI should promote and reinforce rigorous thinking, not
  replace it with generated content
- **Output Validation**: All AI-generated content must be reviewed by
  qualified humans before use
- **Decision Accountability**: Clear human responsibility for all
  AI-assisted decisions

**Covered AI Tools:**

This ADR applies to all AI tools including:

- Development and coding assistance tools
- Content generation and writing assistants
- Data analysis and business intelligence platforms
- Automated testing and code review tools

**Requirements:**

AI tools must not:

- Automatically perform actions in customer-facing environments or on
  production infrastructure
- Process sensitive data with third parties without a formal
  contractual arrangement
- Automatically merge or release changes without human review

AI tools must:

- Run in isolated or local environments (refer to [ADR 001: Application
  Isolation](001-isolation.md)) with minimal permissions
- Have no direct network access to internal systems or databases
- Include technical guardrails against data exfiltration

**Implementation Examples:**

- **Endorsed**: Developer tooling (e.g., [OpenCode](https://github.com/wagov-dtt/tutorials-and-workshops/blob/main/README.md#opencode-ai-agent)) with human code review for all
  generated code before merge
- **Rejected**: Automated tools that merge pull requests or deploy
  without human approval

## Strategic Research

The following AI-assisted security tools are under investigation for potential future adoption:

| Tool | Purpose | Status | Links |
|------|---------|--------|-------|
| [ZeroPath](https://zeropath.com/) | AI-powered security code review and vulnerability detection | Under Investigation | [Documentation](https://docs.zeropath.com/) |
| [Strix](https://github.com/usestrix/strix) | Open-source AI penetration testing agents (self-hostable) | Under Investigation | [Documentation](https://docs.strix.ai/) |

**Model Preferences:**

Where possible, preference should be given to tools using [open weights models](https://artificialanalysis.ai/models/open-source) to support transparency, auditability, and reduced vendor lock-in. Open-source and self-hostable tools (such as Strix) are particularly valuable as they enable:

- Independent security audits of model behaviour and tool functionality
- Local deployment options for sensitive workloads with full data sovereignty
- Greater control over data processing and privacy
- Community-driven improvements and customisation
- Reduced dependency on proprietary third-party services

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
