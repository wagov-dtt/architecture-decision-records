# Architecture Decision Records

# Show available commands
default:
    @just --list

# Build website and PDF from ADRs
build: update-chapters
    quarto render
    @echo "Checking links..."
    @lychee --no-progress '_site/**/*.html' || echo "Link check failed"

# Update _quarto.yml with current ADR files
update-chapters:
    #!/bin/bash
    # Update git hash and chapters in _quarto.yml (prefer tag over commit)
    git_ref=$(git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD)
    yq eval ".git-hash = \"$git_ref\"" -i _quarto.yml
    yq eval '.book.chapters = ["index.qmd", "architecture-principles.qmd"]' -i _quarto.yml
    for dir in */; do
      dir=${dir%/}  # Remove trailing slash
      if ls $dir/*.qmd 1> /dev/null 2>&1; then
        title="$(echo ${dir^} ADRs)"
        yq eval ".book.chapters += [{\"part\": \"$title\", \"chapters\": []}]" -i _quarto.yml
        for file in $(ls $dir/*.qmd | sort -V); do
          yq eval ".book.chapters[-1].chapters += [\"$file\"]" -i _quarto.yml
        done
      fi
    done
    yq eval '.book.chapters += ["CONTRIBUTING.md", "glossary.qmd"]' -i _quarto.yml
    echo "Running markdownlint..."
    markdownlint --fix */*.qmd *.qmd CONTRIBUTING.md AGENT.md README.md || echo "Markdown formatting suggestions found"

# Start development server (static build)
serve: build
    cd _site && python3 -m http.server 8080

# Clean generated files
clean:
    rm -rf _site/

# Full validation
validate:
    vale sync
    @find . -name "*.qmd" -path "./*/[0-9][0-9][0-9]-*.qmd" -exec grep -L "^---$" {} \; | \
    if read file; then echo "Missing frontmatter: $file"; exit 1; else echo "Frontmatter valid"; fi
    @echo "Validating ADR frontmatter schemas..."
    @for file in */[0-9][0-9][0-9]-*.qmd; do \
      if [ -f "$$file" ]; then \
        yq eval '.title, .date, .status' "$$file" > /dev/null || echo "Invalid frontmatter in $$file"; \
      fi \
    done
    @markdownlint */*.qmd *.qmd CONTRIBUTING.md AGENT.md README.md || echo "Markdown formatting suggestions found"
    @vale --no-exit --ignore-syntax *.qmd */*.qmd CONTRIBUTING.md AGENT.md README.md --glob='!glossary.qmd' || echo "Style suggestions found"

# Create/update git release tag
release TAG="":
    #!/bin/bash
    if [ -z "{{TAG}}" ]; then
      tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "v1.0.0")
    else
      tag="{{TAG}}"
    fi
    echo "Updating tag: $tag"
    git tag -f "$tag"
    git push -f origin "$tag"

# Get next ADR number
next-number:
    @find . -name "[0-9][0-9][0-9]-*.qmd" | sed 's/.*\/\([0-9][0-9][0-9]\)-.*/\1/' | sort -n | tail -1 | awk '{printf "%03d\n", $1+1}'
