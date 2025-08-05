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
    yq eval '.book.chapters = ["index.qmd", "architecture-principles.md"]' -i _quarto.yml
    # Process ADR directories first (exclude reference-architectures)
    for dir in */; do
      dir=${dir%/}  # Remove trailing slash
      if [[ "$dir" != "reference-architectures" ]] && ls $dir/*.qmd 1> /dev/null 2>&1; then
        title="$(echo ${dir^} ADRs)"
        yq eval ".book.chapters += [{\"part\": \"$title\", \"chapters\": []}]" -i _quarto.yml
        for file in $(ls $dir/*.qmd | sort -V); do
          yq eval ".book.chapters[-1].chapters += [\"$file\"]" -i _quarto.yml
        done
      fi
    done
    # Process reference-architectures at the end
    if ls reference-architectures/*.qmd 1> /dev/null 2>&1; then
      yq eval '.book.chapters += [{"part": "Reference Architectures", "chapters": []}]' -i _quarto.yml
      for file in $(ls reference-architectures/*.qmd | sort -V); do
        yq eval ".book.chapters[-1].chapters += [\"$file\"]" -i _quarto.yml
      done
    fi
    yq eval '.book.chapters += ["CONTRIBUTING.md", "glossary.md"]' -i _quarto.yml
    
    echo "Running markdownlint..."
    markdownlint --fix */*.qmd *.qmd CONTRIBUTING.md AGENT.md README.md || echo "Markdown formatting suggestions found"
    
    # Render all .qmd files to .md using GFM profile
    echo "Generating all .md files using Quarto GFM profile..."
    quarto render --profile gfm
    
    # Generate ADR index file (now that .md files exist)
    echo "Generating _adr-index.md..."
    
    # Create markdown table from ADR frontmatter
    echo "| ADR | Title | Status | Date |" > _adr-index.md
    echo "|-----|-------|--------|------|" >> _adr-index.md
    
    # Process ADRs by number order
    for file in $(find . -name "[0-9][0-9][0-9]-*.qmd" | sed 's/.*\/\([0-9][0-9][0-9]\)-\(.*\)/\1 &/' | sort -n | cut -d' ' -f2-); do
      if [ -f "$file" ]; then
        number=$(basename "$file" | sed 's/\([0-9][0-9][0-9]\)-.*/\1/')
        title=$(yq --front-matter=extract eval '.title' "$file" 2>/dev/null | sed 's/^"ADR [0-9]*: //' | sed 's/"$//')
        status=$(yq --front-matter=extract eval '.status' "$file" 2>/dev/null)
        date=$(yq --front-matter=extract eval '.date' "$file" 2>/dev/null)
        relative_path="${file#./}"
        md_path="${relative_path%.qmd}.md"
        echo "| [ADR ${number}]($md_path) | $title | $status | $date |" >> _adr-index.md
      fi
    done
    
    # Add Reference Architectures section
    echo "" >> _adr-index.md
    echo "### Reference Architectures" >> _adr-index.md
    echo "" >> _adr-index.md
    echo "| Reference | Title | Status | Date |" >> _adr-index.md
    echo "|-----------|-------|--------|------|" >> _adr-index.md
    
    for file in $(ls reference-architectures/*.qmd 2>/dev/null | sort); do
      if [ -f "$file" ]; then
        title=$(yq --front-matter=extract eval '.title' "$file" 2>/dev/null | sed 's/^"Reference Architecture: //' | sed 's/"$//')
        status=$(yq --front-matter=extract eval '.status' "$file" 2>/dev/null)
        date=$(yq --front-matter=extract eval '.date' "$file" 2>/dev/null)
        basename_title=$(basename "$file" .qmd | tr '-' ' ' | sed 's/.*/\L&/; s/[a-z]*/\u&/g')
        md_path="${file%.qmd}.md"
        echo "| [$basename_title]($md_path) | $title | $status | $date |" >> _adr-index.md
      fi
    done
    
    # Re-render README.qmd with the updated index
    echo "Re-generating README.md with updated index..."
    quarto render --profile gfm README.qmd

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
