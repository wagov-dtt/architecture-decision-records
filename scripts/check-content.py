#!/usr/bin/env python3
"""Validate Hugo content conventions used by this repository."""
from pathlib import Path
import sys

errors: list[str] = []
for path in sorted(Path("content/docs").rglob("*.md")):
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        errors.append(f"{path}: missing Hugo front matter")
    if "```d2" in text:
        errors.append(f"{path}: D2 diagram block must be converted to Mermaid")

if errors:
    print("Content validation failed:")
    for error in errors:
        print(f"  - {error}")
    sys.exit(1)
