# Architecture Decision Records
# Documentation build and validation system

# Show available commands
default:
    @just --list

# === Build Commands ===

# Build documentation website (includes link checking)
build: setup
    mdbook build

# Serve documentation locally (port 8080)
serve:
    mdbook serve --port 8080

# Clean generated files
clean:
    mdbook clean

# === Quality Commands ===

# Lint and fix formatting issues
lint:
    rumdl check --fix .
    @echo "Checking SUMMARY.md completeness..."
    @./scripts/check-summary.sh
    @echo "Checking links (via build)..."
    @mkdir -p book/pandoc/pdf
    @touch book/pandoc/pdf/adr-guide.pdf
    @mdbook build

# === Setup Commands ===

# Install required tools (first time) 
setup:
    mise install
    mise exec tinytex -- tlmgr install dejavu

# === Development Commands ===

# Get next global ADR number
next-number:
    @printf "%03d\n" $$(($$(find development operations security -name "*.md" | grep -o '[0-9]\+' | sort -n | tail -1) + 1))
