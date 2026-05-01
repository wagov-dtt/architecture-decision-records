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
- [oy-cli crate documentation](https://docs.rs/oy-cli/latest/oy/) - local AI
  coding CLI and safety-mode guidance
- [Exploring the zero operator access design of Mantle](https://aws.amazon.com/blogs/machine-learning/exploring-the-zero-operator-access-design-of-mantle/)
  - Amazon Bedrock Mantle zero operator access design

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
- Enforce explicit workspace, shell/process, network, model-provider,
  local-state, and approval boundaries
- Default to read-only or approval-gated modes for untrusted repositories
  and first-look analysis

**Implementation Examples:**

- **Preferred**: [oy-cli](https://docs.rs/oy-cli/latest/oy/) for governed
  agent-backed development and repository audits
- **Rejected**: Automated tools that merge, release, or deploy without
  human approval

## Strategic Research

Future adoption should favour simple agent workflows with strict,
inspectable boundaries: explicit workspace scope, approval-gated
mutation, deterministic audits, and minimal platform magic. Tools with a
similar posture to `oy` are preferred over broad agent platforms that add
opaque orchestration or unnecessary operational complexity.

`bedrock-mantle` is the preferred execution environment for this research
where suitable because it enables access to open models through Amazon
Bedrock and aligns with Mantle's zero operator access design, which AWS
describes as eliminating technical means for AWS operators to access
customer data.

Model and backend selection must consider:

- Evidence of better quality or security on representative development,
  audit, and operations tasks
- Data disclosure to the configured model provider, including snippets,
  command output, tool results, and audit chunks
- Avoiding lock-in to heavily proprietary platforms such as Bedrock
  AgentCore or GitHub Copilot unless there is a clear risk or capability
  justification
- Compatibility with `oy` approval modes, workspace boundaries, and
  deterministic no-tools audits

## Consequences

**Benefits:**

- Ensures human accountability for all AI-assisted decisions
- Maintains compliance with Privacy Act and data sovereignty requirements
- Prevents automated actions in production environments without approval
- Establishes clear audit trail for responsible AI usage
- Standardises agent-backed development on a local CLI with explicit
  approval modes, workspace boundaries, and a deterministic audit path

**Risks if not implemented:**

- Unauthorized data exposure to offshore AI services
- AI making critical decisions without human oversight
- Compliance violations and regulatory breaches
- Operational errors from unchecked AI outputs
