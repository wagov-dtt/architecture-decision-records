#!/usr/bin/env python3
"""Check SUMMARY.md includes maintained markdown files."""

from pathlib import Path
import sys


def main() -> int:
    summary = Path("SUMMARY.md").read_text()
    included_roots = [
        "development",
        "operations",
        "security",
        "reference-architectures",
        "templates",
    ]
    required = [
        Path("README.md"),
        Path("adr-design-guardrails.md"),
        Path("decision-finder.md"),
        Path("proposed-decision-backlog.md"),
        Path("review-schedule.md"),
        Path("CONTRIBUTING.md"),
        Path("compliance-mapping.md"),
        Path("glossary.md"),
    ]
    for root in included_roots:
        required.extend(sorted(Path(root).glob("**/*.md")))

    missing = [str(path) for path in required if str(path) not in summary]
    if missing:
        print("Missing from SUMMARY.md:", *missing, sep="\n  ")
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())
