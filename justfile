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
    yq eval '.book.chapters += ["CONTRIBUTING.md", "glossary.qmd"]' -i _quarto.yml
    
    # Generate ADR index for README.md from frontmatter
    echo "Generating ADR index for README.md..."
    
    # Create markdown table from ADR frontmatter
    tmp_index=$(mktemp)
    echo "| ADR | Title | Status |" > "$tmp_index"
    echo "|-----|-------|--------|" >> "$tmp_index"
    
    # Process ADRs by number order
    for file in $(find . -name "[0-9][0-9][0-9]-*.qmd" | sed 's/.*\/\([0-9][0-9][0-9]\)-\(.*\)/\1 &/' | sort -n | cut -d' ' -f2-); do
      if [ -f "$file" ]; then
        number=$(basename "$file" | sed 's/\([0-9][0-9][0-9]\)-.*/\1/')
        title=$(sed -n '/^title:/p' "$file" | sed 's/title: *"ADR [0-9]*: //' | sed 's/"$//')
        status=$(sed -n '/^status:/p' "$file" | sed 's/status: *//')
        relative_path="${file#./}"
        echo "| [ADR ${number}]($relative_path) | $title | $status |" >> "$tmp_index"
      fi
    done
    
    # Add Reference Architectures section
    echo "" >> "$tmp_index"
    echo "### Reference Architectures" >> "$tmp_index"
    echo "" >> "$tmp_index"
    echo "| Reference | Title | Status |" >> "$tmp_index"
    echo "|-----------|-------|--------|" >> "$tmp_index"
    
    for file in $(ls reference-architectures/*.qmd 2>/dev/null | sort); do
      if [ -f "$file" ]; then
        title=$(sed -n '/^title:/p' "$file" | sed 's/title: *"Reference Architecture: //' | sed 's/"$//')
        status=$(sed -n '/^status:/p' "$file" | sed 's/status: *//')
        basename_title=$(basename "$file" .qmd | tr '-' ' ' | sed 's/.*/\L&/; s/[a-z]*/\u&/g')
        echo "| [$basename_title]($file) | $title | $status |" >> "$tmp_index"
      fi
    done
    
    # Update README.md with the generated index  
    awk '
    /<!-- ADR_INDEX_START -->/ { 
        print 
        print ""
        while ((getline line < "'"$tmp_index"'") > 0) {
            print line
        }
        print ""
        in_section = 1
        next 
    }
    /<!-- ADR_INDEX_END -->/ { 
        in_section = 0 
        print
        next
    }
    !in_section { print }
    ' README.md > README.tmp && mv README.tmp README.md
    
    # Clean up
    rm -f "$tmp_index"
    
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
