#!/bin/bash
# Check that all markdown files are included in SUMMARY.md

exit_code=0

for file in $(find development operations security reference-architectures -name "*.md"); do
    if ! grep -q "$file" SUMMARY.md; then
        echo "Missing: $file"
        exit_code=1
    fi
done

exit $exit_code
