#!/usr/bin/env python3
"""Generate the ADR catalogue embedded in decision-finder.md."""

from argparse import ArgumentParser
from dataclasses import dataclass
from pathlib import Path
import re
import sys


CATALOGUE_PATH = Path("decision-finder.md")
START_MARKER = "<!-- generated-adr-catalogue:start -->"
END_MARKER = "<!-- generated-adr-catalogue:end -->"
ADR_ROOTS = ("development", "operations", "security")
METADATA = re.compile(
    r"^\*\*Status:\*\* (Proposed|Accepted|Superseded) "
    r"\| \*\*Date:\*\* (\d{4}-\d{2}-\d{2}) "
    r"\| \*\*Review:\*\* (\d{4}-\d{2}-\d{2})$"
)
LINK = re.compile(r"\[([^]]+)]\(([^)]+)\)")
SYNOPSIS_FIELDS = (
    "Use when",
    "Avoid when",
    "Decision",
    "Required evidence",
    "Dependencies",
)


@dataclass(frozen=True)
class Adr:
    number: int
    title: str
    path: Path
    status: str
    decision_date: str
    review_date: str
    dependency_paths: tuple[Path, ...]


def synopsis_field(lines: list[str], label: str, path: Path) -> str:
    """Read one potentially wrapped bullet from the Synopsis section."""
    try:
        start = lines.index("## Synopsis") + 1
    except ValueError as error:
        raise ValueError(f"{path}: missing ## Synopsis") from error

    end = next(
        (index for index in range(start, len(lines)) if lines[index].startswith("## ")),
        len(lines),
    )
    prefix = f"- **{label}:**"
    for index in range(start, end):
        if not lines[index].startswith(prefix):
            continue
        parts = [lines[index][len(prefix) :].strip()]
        for continuation in lines[index + 1 : end]:
            if continuation.startswith("- **"):
                break
            if continuation.strip():
                parts.append(continuation.strip())
        return " ".join(parts)
    raise ValueError(f"{path}: Synopsis is missing {label}")


def resolve_dependency(source: Path, target: str) -> Path:
    """Resolve a local Markdown dependency link relative to its source ADR."""
    if "://" in target or target.startswith("#"):
        raise ValueError(f"{source}: dependency must be a local ADR link: {target}")
    clean_target = target.split("#", 1)[0]
    resolved = (source.parent / clean_target).resolve()
    root = Path.cwd().resolve()
    try:
        return resolved.relative_to(root)
    except ValueError as error:
        raise ValueError(f"{source}: dependency escapes the repository: {target}") from error


def read_adrs() -> list[Adr]:
    """Load ADR metadata and structured Synopsis dependencies."""
    adrs = []
    for root in ADR_ROOTS:
        for path in Path(root).glob("[0-9][0-9][0-9]-*.md"):
            lines = path.read_text().splitlines()
            if not lines or not lines[0].startswith("# ADR "):
                raise ValueError(f"{path}: missing ADR title")
            title_match = re.match(r"# ADR (\d{3}): (.+)$", lines[0])
            if not title_match:
                raise ValueError(f"{path}: invalid ADR title")
            metadata = METADATA.match(lines[2] if len(lines) > 2 else "")
            if not metadata:
                raise ValueError(f"{path}: missing or invalid metadata")

            synopsis = {
                field: synopsis_field(lines, field, path) for field in SYNOPSIS_FIELDS
            }
            dependencies = synopsis["Dependencies"]
            dependency_paths = []
            if dependencies != "None.":
                links = LINK.findall(dependencies)
                if not links:
                    raise ValueError(f"{path}: Dependencies must contain ADR links or None.")
                for _, target in links:
                    dependency = resolve_dependency(path, target)
                    if dependency not in dependency_paths:
                        dependency_paths.append(dependency)

            adrs.append(
                Adr(
                    number=int(title_match.group(1)),
                    title=title_match.group(2),
                    path=path,
                    status=metadata.group(1),
                    decision_date=metadata.group(2),
                    review_date=metadata.group(3),
                    dependency_paths=tuple(dependency_paths),
                )
            )

    adrs.sort(key=lambda adr: adr.number)
    numbers = [adr.number for adr in adrs]
    if len(numbers) != len(set(numbers)):
        raise ValueError("ADR numbers must be globally unique")
    return adrs


def render_catalogue(adrs: list[Adr]) -> str:
    """Render the generated Markdown catalogue."""
    by_path = {adr.path: adr for adr in adrs}
    lines = [
        START_MARKER,
        "",
        "| ADR | Domain | Status | Decision date | Review date | Dependencies |",
        "|-----|--------|--------|---------------|-------------|--------------|",
    ]
    for adr in adrs:
        dependency_links = []
        for dependency_path in adr.dependency_paths:
            dependency = by_path.get(dependency_path)
            if dependency is None:
                raise ValueError(f"{adr.path}: dependency is not an ADR: {dependency_path}")
            label = f"ADR {dependency.number:03d}"
            if dependency.status == "Proposed":
                label += " (Proposed)"
            dependency_links.append(f"[{label}]({dependency.path.as_posix()})")
        dependencies = ", ".join(dependency_links) if dependency_links else "None"
        domain = adr.path.parts[0].title()
        lines.append(
            f"| [ADR {adr.number:03d}: {adr.title}]({adr.path.as_posix()}) "
            f"| {domain} | {adr.status} | {adr.decision_date} | {adr.review_date} "
            f"| {dependencies} |"
        )
    lines.extend(["", END_MARKER])
    return "\n".join(lines)


def update_catalogue(content: str, generated: str) -> str:
    """Replace the generated region without changing surrounding headings."""
    if content.count(START_MARKER) != 1 or content.count(END_MARKER) != 1:
        raise ValueError(
            f"{CATALOGUE_PATH}: expected exactly one generated catalogue region"
        )
    before, remainder = content.split(START_MARKER, 1)
    _, after = remainder.split(END_MARKER, 1)
    return before + generated + after


def main() -> int:
    parser = ArgumentParser()
    parser.add_argument(
        "--check", action="store_true", help="fail instead of updating stale content"
    )
    arguments = parser.parse_args()

    try:
        current = CATALOGUE_PATH.read_text()
        expected = update_catalogue(current, render_catalogue(read_adrs()))
    except (OSError, ValueError) as error:
        print(f"Catalogue generation failed: {error}", file=sys.stderr)
        return 1

    if current == expected:
        return 0
    if arguments.check:
        print(
            f"{CATALOGUE_PATH}: generated ADR catalogue is stale; "
            "run `just update-catalogue`",
            file=sys.stderr,
        )
        return 1
    CATALOGUE_PATH.write_text(expected)
    return 0


if __name__ == "__main__":
    sys.exit(main())
