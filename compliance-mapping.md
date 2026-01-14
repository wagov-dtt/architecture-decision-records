# Compliance Mapping

This table maps ADRs to specific controls and requirements in Western Australian and Australian compliance frameworks.

## ACSC Information Security Manual (ISM)

| ADR | Topic | ISM Guidelines & Control IDs | Key Controls |
|-----|-------|------------------------------|--------------|
| [001 Isolation](security/001-isolation.md) | Application isolation | [Guidelines for Networking](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-networking) **(ISM-1182, ISM-0535, ISM-1277, ISM-1517)** | Network segmentation, micro-segmentation, preventing bypass of controls |
| [002 Workloads](operations/002-workloads.md) | Cloud workloads | [Guidelines for Cloud Services](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-cloud-services) **(ISM-1588, ISM-1589, ISM-1452, ISM-0499)** | Cloud security assessment, multi-tenant isolation, virtualisation hardening |
| [004 CI/CD](development/004-cicd.md) | Build and release | [Guidelines for Software Development](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development) **(ISM-1256, ISM-0400, ISM-1419, ISM-2032)** | Secure development lifecycle, environment segregation, automated testing |
| [005 Secrets](security/005-secrets-management.md) | Secrets management | [Guidelines for Cryptography](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-cryptography) **(ISM-0507, ISM-0488, ISM-0518, ISM-1090)** | Key management, secure storage of secrets, key rotation |
| [007 Logging](operations/007-logging.md) | Security logging | [Guidelines for System Monitoring](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-system-monitoring) **(ISM-0580, ISM-1405, ISM-1985, ISM-0988)** | Event logging policy, centralised logging, log protection, time synchronisation |
| [008 Email Auth](security/008-email-authentication.md) | Email authentication | [Guidelines for Email](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-email) **(ISM-0574, ISM-1151, ISM-1540, ISM-0259)** | SPF, DKIM, DMARC, email encryption |
| [010 IaC](operations/010-configmgmt.md) | Infrastructure as code | [Guidelines for System Hardening](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-system-hardening) **(ISM-1211, ISM-1409, ISM-1383)** | Configuration management, automated deployment, drift detection |
| [011 AI Governance](security/011-ai-governance.md) | AI tool governance | [Guidelines for Software Development](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-software-development) **(ISM-2074, ISM-1755, ISM-0226)** | AI usage policy, supply chain risk management, software assessment |
| [012 Privileged Access](security/012-privileged-remote-access.md) | Privileged access | [Guidelines for System Management](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-system-management) **(ISM-1175, ISM-1507, ISM-1483, ISM-1173)** | Restricting privileged access, JIT access, jump servers, MFA for admins |
| [013 Identity](security/013-identity-federation.md) | Identity federation | [Guidelines for Personnel Security](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-personnel-security) **(ISM-0418, ISM-1173, ISM-1420, ISM-1505)** | Authentication, MFA, federated identity trust, credential management |
| [016 Edge Protection](security/016-edge-protection.md) | WAF and CDN | [Guidelines for Gateways](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism/cyber-security-guidelines/guidelines-gateways) **(ISM-1192, ISM-1262, ISM-1460)** | Web application firewalls, traffic inspection, DDoS protection |

## WA Government Cyber Security Policy (WA CSP)

The [2024 WA Government Cyber Security Policy](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy) defines baseline cyber security requirements for WA Government entities.

| ADR | WA CSP Requirement | Section |
|-----|-------------------|---------|
| [001 Isolation](security/001-isolation.md) | Cyber security context & risk management | 2.1, 2.2 |
| [002 Workloads](operations/002-workloads.md) | Supply chain risk, data offshoring | 2.3, 1.5 |
| [005 Secrets](security/005-secrets-management.md) | Information security (Cryptography) | 3.1 |
| [006 Policy Enforcement](operations/006-policy-enforcement.md) | Cyber security governance | 1.4 |
| [007 Logging](operations/007-logging.md) | Continuous monitoring | 4.2 |
| [011 AI Governance](security/011-ai-governance.md) | Supply chain risk management | 2.3 |
| [012 Privileged Access](security/012-privileged-remote-access.md) | Identity and access management | 3.6 |
| [013 Identity](security/013-identity-federation.md) | Identity and access management | 3.6 |

**Implementation Guidance:**

- [1.1 Accountable Authority](https://www.wa.gov.au/government/publications/2024-wa-government-cyber-security-policy) - See Policy Implementation section
- [1.3 Cyber Security Operations](https://soc.cyber.wa.gov.au/) - WA SOC Guidelines
- [1.5 Data Offshoring Governance](https://www.wa.gov.au/government/publications/data-offshoring-position)

## WA Government AI Policy

The [WA Government AI Policy and Assurance Framework](https://www.wa.gov.au/government/publications/wa-government-artificial-intelligence-policy-and-assurance-framework) requires AI Accountable Officers and self-assessments for AI projects.

| ADR | WA AI Policy Requirement |
|-----|-------------------------|
| [011 AI Governance](security/011-ai-governance.md) | AI Accountable Officer, AI Assurance Framework self-assessment |
| [015 Data Governance](operations/015-data-governance.md) | Data quality validation for AI systems |

**Key Requirements:**

- **Nominate:** AI Accountable Officer per entity
- **Assess:** Complete [AI Assurance Framework self-assessment](https://www.wa.gov.au/government/publications/wa-government-artificial-intelligence-policy-and-assurance-framework) (downloadable template available on policy page)
- **Submit:** Refer high-risk projects (or >$5M) to the [Office of Digital Government](https://www.wa.gov.au/organisation/department-of-the-premier-and-cabinet/office-of-digital-government)

## Privacy and Responsible Information Sharing (PRIS)

The [Privacy and Responsible Information Sharing](https://www.wa.gov.au/government/privacy-and-responsible-information-sharing) (PRIS) framework governs personal information handling and upcoming statutory requirements.

| ADR | PRIS Alignment |
|-----|---------------|
| [007 Logging](operations/007-logging.md) | Minimise PII in logs (Data Minimisation) |
| [013 Identity](security/013-identity-federation.md) | Data minimisation, consent protocols |
| [015 Data Governance](operations/015-data-governance.md) | Information classification, retention schedules |

## Digital ID Act 2024 (Commonwealth)

The [Digital ID Act 2024](https://www.digitalidsystem.gov.au/what-is-digital-id/digital-id-act-2024) establishes privacy safeguards for the Australian Government Digital ID System (AGDIS).

| ADR | Digital ID Act Requirement |
|-----|---------------------------|
| [013 Identity](security/013-identity-federation.md) | Data minimisation (s15), no single identifiers (s16), voluntary participation (s18), biometric safeguards (Part 4) |

**Key Privacy Safeguards:**

- Prohibit collection beyond identity verification requirements
- Prevent tracking across services using persistent identifiers
- Users cannot be required to create a Digital ID for service access (voluntary)
- Strict restrictions on collection, use, and disclosure of biometric information

## Additional Resources

- [ACSC Essential Eight](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/essential-eight)
- [WA SOC Cyber Security Guidelines](https://soc.cyber.wa.gov.au/)
- [WA Government Data Offshoring Position](https://www.wa.gov.au/government/publications/data-offshoring-position)
- [National Framework for AI Assurance in Government](https://www.digital.gov.au/policy/ai-in-government)
