# Reference Architecture: Pattern Name

**Status:** Proposed | **Date:** YYYY-MM-DD

## When to Use This Pattern

Clear use case description for when to apply this architecture.

## Overview

Brief template description focusing on practical implementation.

## Core Components

```mermaid
flowchart LR
    source[Data Sources]
    process[Processing Layer]
    output[Output Systems]

    source -->|ingest data| process
    process -->|deliver results| output

    style source fill:#e3f2fd,stroke:#1976d2
    style process fill:#e8f5e8,stroke:#388e3c
    style output fill:#f3e5f5,stroke:#7b1fa2
```

## Project Kickoff Steps

1. **Step Name** - Follow relevant ADRs for implementation
2. **Next Step** - *ADR needed for missing standards*
3. **Final Step** - Reference to existing practices
