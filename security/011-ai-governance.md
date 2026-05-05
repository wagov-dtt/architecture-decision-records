# ADR 011: AI Tool and Agent Governance

**Status:** Accepted | **Date:** 2025-08-15

## Context

Generative and agentic AI tools used for development and operations can
process sensitive data, call tools, and produce outputs that affect
security, privacy, and compliance. Without governance, they can expose
data, make biased or incorrect recommendations, misuse privileges, and
create compliance failures.

Agentic AI adds autonomy: models can use tools, external data, memory,
planning workflows, and execution privileges. This increases the attack
surface through prompt injection, unsafe tool use, privilege creep,
identity spoofing, third-party component compromise, cascading failures,
and opaque audit trails.

High-risk scenarios include:

- **Automated Decision-Making**: policy, approval, or resource allocation
  decisions without human review
- **Government Data Processing**: sensitive organisational data processed
  by offshore or unapproved AI services
- **Uncontrolled Outputs**: generated content, code, or analysis used
  without qualified validation
- **Privacy Violations**: personal information processed without consent
  or required controls
- **Agentic Tool Use**: shell, network, API, email, data, or
  infrastructure actions beyond a tightly approved scope

References:

- [ACSC Information Security Manual
  (ISM)](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)
- [ACSC: Careful adoption of agentic AI
  services](https://www.cyber.gov.au/business-government/secure-design/artificial-intelligence/careful-adoption-of-agentic-ai-services)
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

Implement mandatory human oversight for all AI tool usage, with
pre-approval for any AI tool that processes organisational data, uses
agents or external tools, or generates outputs used in an official
capacity.

AI security, including agentic AI security, must be managed inside normal
cyber security governance: secure-by-design, defence in depth, identity
and access management, monitoring, incident response, and supply chain
risk management.

**Human Oversight Requirements:**

Adopt a values-based approach to AI governance (per [Oxide RFD
576](https://rfd.shared.oxide.computer/rfd/0576)):

- **Responsibility**: Humans are accountable for AI-generated artifacts
- **Rigor**: AI should support rigorous thinking, not replace it
- **Validation**: Qualified humans must review AI-generated content before
  use
- **Accountability**: AI-assisted decisions must have a clear human owner

Human approval gates must be set by system designers and operators, not
by the AI system. Prior human approval is required for high-impact or
hard-to-reverse actions, including production changes, network egress,
data or log deletion, releases, deployments, procurement, payments,
approvals, and customer-facing actions.

**Approval Matrix:**

| Use case | Default stance | Approval |
|----------|----------------|----------|
| Local or read-only coding help with no sensitive data | Allowed | Normal human review |
| External AI with organisational data | Restricted | Pre-approval and contract |
| Agent with shell, network, API, or memory tools | Restricted | Risk assessment and approval gates |
| Production or customer-facing action | Prohibited by default | Explicit human approval |
| Delete logs or audit records | Prohibited by default | Separate human approval |

**Covered AI Tools:**

This ADR applies to all AI tools including:

- Development and coding assistants
- Content generation and writing assistants
- Data analysis and business intelligence platforms
- Automated testing and code review tools
- Agentic AI systems, autonomous agents, multi-agent workflows, and tools
  with API, shell, network, memory, or execution privileges

**Requirements:**

AI tools must not:

- Automatically act in customer-facing or production environments
- Process sensitive data with third parties without a formal contractual
  arrangement
- Merge, release, deploy, or alter production state without human review
- Receive broad or unrestricted access to sensitive data, critical
  systems, logs, credentials, networks, or production environments
- Decide when human approval, escalation, rollback, or audit deletion is
  required

AI tools must:

- Be limited to low-risk and non-sensitive tasks unless explicitly
  approved through risk assessment and accountable ownership
- Run in isolated or local environments (refer to [ADR 001: Application
  Isolation](001-isolation.md)) with minimal permissions and bounded blast
  radius
- Use explicit workspace, shell/process, network, model-provider,
  local-state, and approval boundaries
- Default to read-only or approval-gated modes for untrusted repositories
  and first-look analysis
- Apply least privilege to every agent, tool, credential, API, and
  sub-task, scoped to the required resource, operation, and timeframe
- Prefer ephemeral or just-in-time credentials for privileged actions
- Validate inputs, prompt context, tool responses, third-party components,
  and generated outputs before consequential use
- Log tool calls, approvals, denied actions, policy decisions,
  model-provider disclosures, and official AI-generated outputs
- Fail safe: stop and escalate when uncertain, rate-limited, degraded, or
  denied by policy

**Agentic AI Adoption Controls:**

Agentic AI adoption must follow ACSC-aligned controls:

- Start with low-risk, non-sensitive tasks and expand access or autonomy
  only after monitoring, testing, and risk review
- Threat model prompt injection, confused-deputy abuse, identity spoofing,
  third-party tools, data exfiltration, cascading failures, and credential
  compromise
- Test agents in sandboxes before production use, including adversarial
  and failure-mode testing
- Maintain trusted inventories for model providers, tools, prompts,
  datasets, and agent components
- Monitor runtime behaviour, including anomalous resource use, guardrail
  triggers, denied actions, and attempts to bypass approval or logging
- Separate high-risk agents into distinct security domains and avoid
  implicit trust between agents

**Required Evidence:**

Approved AI tool use must retain enough evidence for review:

- Approved tool or register entry
- Data disclosure and model-provider assessment where applicable
- Risk assessment for agentic workflows
- Human approval records for high-impact actions
- Logs of tool calls, denied actions, generated outputs, and approvals

**Exceptions:**

Exceptions require documented risk acceptance by the accountable owner,
time-bound approval, and compensating controls. Exceptions must not remove
human accountability for consequential decisions or high-impact actions.

**Implementation Examples:**

- **Preferred**: [oy-cli](https://docs.rs/oy-cli/latest/oy/) for governed
  agent-backed development and repository audits
- **Rejected**: Automated tools that merge, release, deploy, alter
  production state, or delete audit records without human approval

## Strategic Research

Future adoption should favour simple agent workflows with inspectable
boundaries: explicit workspace scope, approval-gated mutation, least
privilege, deterministic audits, continuous monitoring, fail-safe
defaults, and reversible deployment. Tools with a similar posture to `oy`
are preferred over broad agent platforms that add opaque orchestration,
implicit trust, or unnecessary operational complexity.

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
- Compatibility with `oy` approval modes, workspace boundaries,
  deterministic no-tools audits, least privilege, audit logging, safe
  rollback, and human approval gates

## Consequences

**Benefits:**

- Ensures human accountability for all AI-assisted decisions
- Maintains compliance with Privacy Act and data sovereignty requirements
- Prevents automated production actions without approval
- Establishes an audit trail for responsible AI usage
- Aligns agentic AI adoption with ACSC guidance: low-risk initial use,
  least privilege, monitoring, progressive deployment, and human approval
  for high-impact actions

**Risks if not implemented:**

- Unauthorized data exposure to offshore AI services
- AI making critical decisions without human oversight
- Compliance violations and regulatory breaches
- Operational errors from unchecked AI outputs
- Agent compromise, confused-deputy abuse, identity spoofing, tool misuse,
  cascading failures, or audit gaps from over-privileged autonomous agents
