# ADR 006: Automated Policy Enforcement

**Status:** Proposed | **Date:** 2025-07-29

## Context

Cloud infrastructure requires automated policy enforcement to prevent
misconfigurations, ensure compliance, and provide secure network access
patterns. Manual checking cannot scale effectively across multiple
accounts and services.

## Decision

Implement comprehensive automated policy enforcement using AWS native
services for governance, network security, and access control.

```d2
control_tower: AWS Control Tower {
  style: {
    fill: "#e3f2fd"
    stroke: "#1976d2"
  }
}

transit_gw: Transit Gateway {
  style: {
    fill: "#e8f5e8"
    stroke: "#388e3c"
  }
}

security_groups: Security Groups {
  style: {
    fill: "#f3e5f5"
    stroke: "#7b1fa2"
  }
}

config: AWS Config {
  style: {
    fill: "#fff3e0"
    stroke: "#f57c00"
  }
}

control_tower -> config: compliance monitoring
control_tower -> security_groups: policy enforcement
transit_gw -> security_groups: network access
config: - detect drift\n- monitor rules
```

### Governance Foundation

- **AWS Control Tower**: Account factory, guardrails, and compliance
  monitoring across organisation
- **Service Control Policies**: Preventive controls blocking
  non-compliant resource creation
- **AWS Config Rules**: Detective controls for compliance monitoring and
  drift detection

### Network Security & Access

- **Transit Gateway**: Central hub for intra-account resource exposure
  via security groups
- **Security Group References**: Use security group IDs instead of
  hardcoded IP addresses for dynamic, maintainable access policies
- **Shield Advanced**: DDoS protection per [ADR 016: Web Application Edge Protection](../security/016-edge-protection.md) and egress intrusion detection
  for public-facing resources
- **VPC Flow Logs**: Complete egress traffic monitoring and analysis per
  [WA SOC Cyber Network Management
  Guideline](https://soc.cyber.wa.gov.au/guidelines/network-management/)

**Note**: This approach creates dependency on AWS for traffic and
network protection. Open-source equivalents include [Security
Onion](https://securityonionsolutions.com/) for network security
monitoring, [OPNsense](https://opnsense.org/) and
[pfSense](https://www.pfsense.org/) for firewall and intrusion detection
capabilities.

### Core Policy Areas

- **Encryption**: Mandatory encryption for all data stores and
  communications
- **Access Control**: IAM least-privilege access and security
  group-based resource access
- **Resource Tagging**: Governance and cost allocation requirements
- **Data Sovereignty**: Geographic restrictions for jurisdiction
  compliance
- **Network Segmentation**: Security group-based micro-segmentation over
  IP-based rules

**Implementation Requirements:**

- Implement policy validation in CI/CD pipelines following [ADR 010: Infrastructure as Code](010-configmgmt.md)
- Use security group references over hardcoded IP addresses for maintainable policies
- Monitor VPC Flow Logs for egress traffic analysis and anomaly detection

## Consequences

**Benefits:**

- Proactive security misconfiguration prevention through automated guardrails
- Comprehensive egress traffic visibility via [ADR 007: Centralised Security Logging](007-logging.md)
- Centralised network access management reducing operational complexity

**Risks if not implemented:**

- Security misconfigurations deploying to production environments
- Unmonitored egress traffic enabling data exfiltration
- Fragmented access policies creating security gaps
