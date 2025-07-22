# Architecture Decision Records

# Show available commands
default:
    @just --list

# Build website and PDF from ADRs using Quarto
build:
    quarto render

# Start local development server on port 8080
serve:
    quarto serve --port 8080

# Remove all generated files and artifacts
clean:
    rm -rf _site/ _book/ *.pdf

# Run comprehensive validation (format, prose style, and writing quality)
validate:
    @echo "🔍 Validating ADR files..."
    @echo "Checking frontmatter..."
    @find . -name "*.md" -path "./*/[0-9][0-9][0-9]-*.md" -exec grep -L "^---$" {} \; | \
    if read file; then echo "❌ Missing frontmatter: $file"; exit 1; else echo "✅ Frontmatter valid"; fi
    @echo "Checking for common mistakes..."
    @grep -r "Database\|Security\|Frontend.*\(issues\|problems\|changes\)" */[0-9][0-9][0-9]-*.md | \
    if read line; then echo "⚠️  Generic title found: $line"; fi
    @grep -r "What is the problem\|What should become\|What will happen" */[0-9][0-9][0-9]-*.md | \
    if read line; then echo "⚠️  Template placeholder found: $line"; fi
    @echo "Checking prose style with Vale..."
    @vale --no-exit *.md */*.md || echo "⚠️  Style suggestions found"
    @echo "Checking writing quality..."
    @write-good --no-passive *.md */*.md || echo "⚠️  Writing suggestions found"
    @echo "✅ Validation complete"

# Check only YAML frontmatter format (fastest validation)
validate-format:
    @echo "Checking frontmatter..."
    @find . -name "*.md" -path "./*/[0-9][0-9][0-9]-*.md" -exec grep -L "^---$" {} \; | \
    if read file; then echo "❌ Missing frontmatter: $file"; exit 1; else echo "✅ Frontmatter valid"; fi

# Run prose linting with Vale style checker  
validate-prose:
    @echo "Checking prose style..."
    @vale --no-exit *.md */*.md || echo "ℹ️  See suggestions above to improve clarity and consistency"

# Find the next sequential ADR number to use
next-number:
    @find . -name "[0-9][0-9][0-9]-*.md" | sed 's/.*\/\([0-9][0-9][0-9]\)-.*/\1/' | sort -n | tail -1 | awk '{printf "%03d\n", $1+1}'
