# Architecture Decision Records
# Documentation build and validation system

# Show all available commands
default:
    @just --list

# Preview documentation locally (port 8080)
[group('development')]
serve: lint
    mdbook serve --port 8080

# Get next ADR number for new files
[group('development')]
next-number:
    #!/usr/bin/env python3
    import glob, re
    
    numbers = [int(m.group()) for d in ["development", "operations", "security"] 
               for f in glob.glob(f"{d}/**/*.md", recursive=True)
               if (m := re.search(r'\d+', f))]
    print(f"{max(numbers, default=0) + 1:03d}")

# Run all checks and fixes
[group('quality')]
lint:
    rumdl check --fix .
    just check-metadata
    just check-summary
    lychee '*.md' '**/*.md' --exclude-path book

# Run checks with tolerant lychee (for CI where external sites may rate-limit)
[group('quality')]
lint-ci:
    rumdl check --fix .
    just check-metadata
    just check-summary
    lychee '*.md' '**/*.md' --exclude-path book || true

# Verify SUMMARY.md includes all markdown files
[group('quality')]
check-summary:
    python3 scripts/check_summary.py

# Verify maintained markdown has annual review metadata
[group('quality')]
check-metadata:
    python3 scripts/check_metadata.py

# Build documentation website (includes link checking)
[group('build')]
build: setup lint
    mdbook build

# Build for CI (tolerates transient link check failures)
[group('build')]
build-ci: setup lint-ci
    mdbook build

# Clean generated files
[group('build')]
clean:
    mdbook clean

# Install required tools and dependencies
[group('setup')]
setup:
    mise install
    bash -eu -c 'missing=""; for tool in mdbook-mermaid; do command -v "$tool" >/dev/null || missing="$missing $tool"; done; if [ -z "$missing" ]; then exit 0; fi; echo "Missing required tools:$missing" >&2; echo "Run '\''cargo install mdbook-mermaid'\'' to install." >&2; exit 1;'
