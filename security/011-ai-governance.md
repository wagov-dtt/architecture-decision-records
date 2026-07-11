# ADR 011: AI Tool and Agent Governance

**Status:** Accepted | **Date:** 2026-07-11 | **Review:** 2027-07-11

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
- [WA Data Offshoring Governance](https://www.wa.gov.au/system/files/2025-06/dataoffshoringgovernancewithwadataoffshoringposition.pdf)
- [WA Information Classification Policy](https://www.wa.gov.au/government/document-collections/western-australian-information-classification-policy)
- [Linux Foundation Agentic AI
  Foundation](https://www.linuxfoundation.org/press/linux-foundation-announces-the-formation-of-the-agentic-ai-foundation)
- [Oxide RFD 576: Using LLMs at
  Oxide](https://rfd.shared.oxide.computer/rfd/0576) - values-based
  approach to AI tool governance

## Decision

Assign a human owner accountable for every AI-assisted system and decision.
Governance depth, approval gates, validation, and monitoring must be
proportionate to risk rather than triggered by AI use alone.

AI security, including agentic AI security, must be managed inside normal
cyber security governance: secure-by-design, defence in depth, identity
and access management, monitoring, incident response, and supply chain
risk management.

**Risk Tiers:**

Assess each use case using the sensitivity and volume of data, consequence
to people or government, degree of autonomy and privilege, and whether
effects are detectable and reversible:

| Tier | Typical characteristics | Minimum governance |
|------|-------------------------|--------------------|
| Low | Non-sensitive, advisory, reversible | Accountable owner and normal review |
| Moderate | Organisational data or bounded tools; material but reversible effect | Documented assessment, testing, monitoring, and escalation |
| High | Sensitive data, significant rights or service effect, high autonomy, privileged access, or hard-to-reverse action | Prior approval, independent assurance, explicit human gates, and continuous monitoring |

Reassess the tier when data, model, tools, autonomy, users, or consequences
materially change.

**Human Accountability:**

Adopt a values-based approach to AI governance (per [Oxide RFD
576](https://rfd.shared.oxide.computer/rfd/0576)):

- **Responsibility**: Humans are accountable for AI-generated artifacts
- **Rigor**: AI should support rigorous thinking, not replace it
- **Validation**: Validation must match the risk and intended use
- **Accountability**: AI-assisted decisions must have a clear human owner

Human approval gates must be set by system designers and operators, not by
the AI system. Prior human approval is required for high-impact or
hard-to-reverse actions. Lower-risk, bounded, observable, and reversible
actions may run under prior system approval with monitoring, limits, and an
accountable owner.

**Approval Matrix:**

| Use case | Default stance | Approval |
|----------|----------------|----------|
| Local or read-only coding help with no sensitive data | Allowed | Normal human review |
| External AI with organisational data | Risk assessed | Approved service and contract |
| Agent with shell, network, API, or memory tools | Risk assessed | Bounded permissions and tier-based gates |
| High-impact or hard-to-reverse action | Prohibited by default | Prior explicit human approval |
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

- Receive sensitive, security-classified, personal, or Tier 1 Risk
  information through public or consumer AI services
- Take high-impact or hard-to-reverse actions without prior human approval
- Process sensitive data with third parties without a formal contractual
  arrangement
- Alter production state outside approved risk-tier controls and rollback
- Receive broad or unrestricted access to sensitive data, critical
  systems, logs, credentials, networks, or production environments
- Decide when human approval, escalation, rollback, or audit deletion is
  required

AI tools must:

- Be risk-tiered, approved for their data and consequence, and assigned an
  accountable owner before use
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
- Apply information classification before disclosure and minimise prompts,
  retrieval context, logs, memory, and retained outputs
- Assess provider processing and support locations, subcontractors,
  retention, model-training use, deletion, incident notification, and exit
  arrangements before enterprise use
- Prevent processing outside approved locations and purposes through
  contract and technical configuration; assess all offshoring under [WA Data
  Offshoring Governance](https://www.wa.gov.au/system/files/2025-06/dataoffshoringgovernancewithwadataoffshoringposition.pdf)

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
- Information classification, retention, processing-location, and supplier
  assessment where applicable
- Risk assessment for agentic workflows
- Human approval records for high-impact actions
- Logs of tool calls, denied actions, generated outputs, and approvals

**Exceptions:**

Exceptions require documented risk acceptance by the accountable owner,
time-bound approval, and compensating controls. Exceptions must not remove
human accountability for consequential decisions or high-impact actions.

**Non-Normative Implementation Examples:**

Products are options only and require the same agency assessment. Examples
include [oy-cli](https://docs.rs/oy-cli/latest/oy/) for repository research,
[Amazon Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-bedrock.html),
[Microsoft Foundry](https://learn.microsoft.com/en-us/azure/foundry/what-is-foundry),
and [Google Vertex AI Model Garden](https://cloud.google.com/vertex-ai/generative-ai/docs/model-garden/explore-models).

Provider statements, model cards, certifications, or assurance features are
inputs to assessment, not proof that an agency use case is safe, compliant,
accurate, unbiased, or fit for purpose. Agencies must validate controls and
outcomes against their own data, threats, users, and consequences.

## Strategic Research

Future research may evaluate simple agent workflows with inspectable
boundaries: explicit workspace scope, approval-gated mutation, least
privilege, deterministic audits, continuous monitoring, fail-safe defaults,
and reversible deployment. Research involving `oy`, Bedrock, Foundry, or
Model Garden is non-normative and does not establish a preferred provider.

Service-facing AI integrations should follow [Reference Architecture:
AI-Assisted Digital
Services](../reference-architectures/ai-assisted-digital-services.md):
applications call an internal Open Responses-compatible gateway, not model
providers directly. The gateway should enforce data minimisation, approved
models, logging, and provider privacy settings such as `store: false` where
supported.

Model and backend selection must consider:

- Evidence of better quality or security on representative development,
  audit, and operations tasks
- Data disclosure to the configured model provider, including snippets,
  command output, tool results, and audit chunks
- Portability, exit arrangements, and the justification for proprietary
  model or agent features
- Compatibility with required approval modes, workspace boundaries, least
  privilege, audit logging, safe rollback, and human approval gates

## Consequences

**Benefits:**

- Ensures human accountability for all AI-assisted decisions
- Supports applicable privacy, information-classification, and data-location
  obligations
- Requires prior approval for high-impact or hard-to-reverse actions
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
