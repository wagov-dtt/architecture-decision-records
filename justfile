# Architecture Decision Records
# Documentation build and validation system

# Show all available commands
default:
    @just --list

# Preview documentation locally (port 8080)
[group('development')]
serve: precheck
    mise exec -- bash -lc 'PATH="$HOME/.local/bin:$PATH" hugo server --bind 0.0.0.0 --port 8080 --buildDrafts'

# Get next ADR number for new files
[group('development')]
next-number:
    #!/usr/bin/env python3
    import glob, re

    numbers = [int(m.group()) for d in ["content/docs/development", "content/docs/operations", "content/docs/security"]
               for f in glob.glob(f"{d}/**/*.md", recursive=True)
               if (m := re.search(r'\d+', f))]
    print(f"{max(numbers, default=0) + 1:03d}")

# Run all checks and fixes
[group('quality')]
lint: precheck
    lychee --root-dir public '*.md' 'content/**/*.md' --exclude-path public --exclude-path resources/_gen

# Run checks with tolerant lychee (for CI where external sites may rate-limit)
[group('quality')]
lint-ci: precheck
    lychee --root-dir public '*.md' 'content/**/*.md' --exclude-path public --exclude-path resources/_gen || true

# Verify docs content has Hugo front matter and no D2 blocks
[group('quality')]
check-content:
    python3 scripts/check-content.py

# Format and validate local content
[group('quality')]
precheck:
    rumdl check --fix .
    just check-content

# Build documentation website (includes link checking)
[group('build')]
build: setup precheck
    mise exec -- bash -lc 'PATH="$HOME/.local/bin:$PATH" hugo --minify'
    just lint

# Build for CI (tolerates transient link check failures)
[group('build')]
build-ci: setup precheck
    mise exec -- bash -lc 'PATH="$HOME/.local/bin:$PATH" hugo --minify'
    just lint-ci

# Clean generated files
[group('build')]
clean:
    rm -rf public resources/_gen .hugo_build.lock assets/jsconfig.json hugo_stats.json

# Install required tools and dependencies
[group('setup')]
setup:
    mise install
    scripts/install-hugo-extended.sh
