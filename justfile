# Architecture Decision Records
# Documentation build and validation system

# Show all available commands
default:
    @just --list

# Preview documentation locally (port 8080)
[group('development')]
serve:
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
    @echo "Checking links (via build)..."
    @mdbook build

# Verify SUMMARY.md includes all markdown files
[group('quality')]
check-summary:
    #!/usr/bin/env python3
    import glob, sys
    
    files = sum([glob.glob(f"{d}/**/*.md", recursive=True) 
                for d in ["development", "operations", "security", "reference-architectures"]], [])
    summary = open("SUMMARY.md").read()
    missing = [f for f in files if f not in summary]
    
    if missing:
        print("Missing from SUMMARY.md:", *missing, sep="\n  ")
        sys.exit(1)

# Build documentation website (includes link checking)
[group('build')]
build: setup
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
    mise exec tinytex -- tlmgr install svg
    which rsvg-convert || sudo apt-get -y update && sudo apt-get install -y librsvg2-bin

