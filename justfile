# Architecture Decision Records

# Show available commands
default:
    @just --list

# Build website and PDF from ADRs
build:
    just update-chapters
    quarto render

# Update _quarto.yml with current ADR files
update-chapters:
    #!/bin/bash
    yq eval '.book.chapters = ["index.qmd", "architecture-principles.md"]' -i _quarto.yml
    for dir in development operations security; do
      if ls $dir/*.md 1> /dev/null 2>&1; then
        title="$(echo ${dir^} ADRs)"
        yq eval ".book.chapters += [{\"part\": \"$title\", \"chapters\": []}]" -i _quarto.yml
        for file in $(ls $dir/*.md | sort); do
          yq eval ".book.chapters[-1].chapters += [\"$file\"]" -i _quarto.yml
        done
      fi
    done

# Start development server
serve:
    quarto preview --port 8080

# Clean generated files
clean:
    rm -rf _site/

# Full validation
validate:
    vale sync
    @find . -name "*.md" -path "./*/[0-9][0-9][0-9]-*.md" -exec grep -L "^---$" {} \; | \
    if read file; then echo "❌ Missing frontmatter: $file"; exit 1; else echo "✅ Frontmatter valid"; fi
    @vale --no-exit *.md */*.md || echo "ℹ️ Style suggestions found"
    @write-good --no-passive *.md */*.md || echo "ℹ️ Writing suggestions found"

# Get next ADR number
next-number:
    @find . -name "[0-9][0-9][0-9]-*.md" | sed 's/.*\/\([0-9][0-9][0-9]\)-.*/\1/' | sort -n | tail -1 | awk '{printf "%03d\n", $1+1}'
