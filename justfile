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
    just check-summary
    lychee '*.md' '**/*.md' --exclude-path book

# Verify SUMMARY.md includes all markdown files
[group('quality')]
check-summary:
    python3 -c "import glob, sys; files = sum([glob.glob(f'{d}/**/*.md', recursive=True) for d in ['development', 'operations', 'security', 'reference-architectures']], []); summary = open('SUMMARY.md').read(); missing = [f for f in files if f not in summary]; print('Missing from SUMMARY.md:', *missing, sep='\n  ') or sys.exit(1) if missing else None"

# Build documentation website (includes link checking)
[group('build')]
build: setup lint
    mdbook build
    cp book/pandoc/pdf/architecture-decision-records.pdf book/html/architecture-decision-records.pdf

# Clean generated files
[group('build')]
clean:
    mdbook clean

# Install required tools and dependencies
[group('setup')]
setup:
    mise install
    which pandoc || sudo apt-get -y update && sudo apt-get install -y pandoc texlive texlive-pictures librsvg2-bin
