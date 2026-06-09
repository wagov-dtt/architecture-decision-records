#!/usr/bin/env python3
"""Check maintained markdown metadata."""

from datetime import date
from pathlib import Path
import re
import sys


METADATA = re.compile(
    r"^\*\*Status:\*\* (Proposed|Accepted|Superseded) "
    r"\| \*\*Date:\*\* (\d{4}-\d{2}-\d{2}) "
    r"\| \*\*Review:\*\* (\d{4}-\d{2}-\d{2})$"
)
TEMPLATE_METADATA = re.compile(
    r"^\*\*Status:\*\* Proposed "
    r"\| \*\*Date:\*\* YYYY-MM-DD "
    r"\| \*\*Review:\*\* YYYY-MM-DD$"
)


def expected_annual_review(document_date: date) -> date:
    """Return the annual review date one year after the document date."""
    try:
        return document_date.replace(year=document_date.year + 1)
    except ValueError:
        return document_date.replace(year=document_date.year + 1, day=28)


def main() -> int:
    failures = []

    for path in sorted(Path(".").glob("**/*.md")):
        if any(part in {".git", "book", "node_modules"} for part in path.parts):
            continue
        if path.name == "SUMMARY.md":
            continue

        lines = path.read_text().splitlines()
        metadata = lines[2] if len(lines) > 2 else ""

        if path.parts and path.parts[0] == "templates":
            if not TEMPLATE_METADATA.match(metadata):
                failures.append(f"{path}: invalid template metadata")
            continue

        match = METADATA.match(metadata)
        if not match:
            failures.append(f"{path}: missing or invalid metadata")
            continue

        document_date = date.fromisoformat(match.group(2))
        review_date = date.fromisoformat(match.group(3))
        expected_review = expected_annual_review(document_date)
        if review_date != expected_review:
            failures.append(
                f"{path}: review date {review_date} should be {expected_review}"
            )

    if failures:
        print("Metadata check failed:", *failures, sep="\n  ")
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())
