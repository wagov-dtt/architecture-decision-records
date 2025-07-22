# AGENT.md - Development Guide

## Commands

- **Build**: `just build` (builds website/PDF from ADRs)  
- **Preview**: `just serve` (development server on port 8080)
- **Validate**: `just validate` (format, prose, and writing quality)
- **Format check**: `just validate-format` (frontmatter only)
- **Prose check**: `just validate-prose` (style and clarity)
- **Next number**: `just next-number` (shows next ADR number)

## Development Setup

The devcontainer automatically installs:
- `just` command runner (via Homebrew)
- `quarto` for website/PDF generation
- `vale` for prose linting and style checking
- `write-good` for writing quality analysis
- Port 8080 forwarded for preview server

## For New Contributors

1. Open repository in GitHub Codespaces or VS Code with devcontainer
2. Wait for setup to complete (installs just + quarto automatically)
3. Run `just next-number` to see what number to use
4. Create your ADR file in the appropriate directory
5. Copy template from README.md and fill in your content
6. Run `just validate` to check your ADR format
7. Run `just serve` to preview the website locally
8. Update README.md to add your ADR to the list
9. Submit PR with your changes

## Troubleshooting

**Common Issues:**
- **Permission errors**: Restart devcontainer if Homebrew setup fails
- **Command not found**: Run `eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"` 
- **Validation errors**: Check frontmatter format matches template exactly
- **Preview not loading**: Ensure port 8080 is properly forwarded

**Getting Help:**
- Check existing ADRs for examples
- Run `just validate-format` for quick frontmatter check
- Use `just validate-prose` to focus on writing quality

## Release Process (Maintainers)

1. Review and accept ADRs (change status to Accepted)
2. Update README.md with accepted ADRs
3. Create git tag and release through GitHub
