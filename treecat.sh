#!/bin/bash

# Output file name
OUTPUT_FILE="output.txt"

# Path to .gitignore and additional ignore patterns
GITIGNORE_FILE=".gitignore"
CUSTOM_IGNORE_PATTERNS=("*.log" "*.tmp" "*.backup")

# Clear the output file
echo "" > $OUTPUT_FILE

# Function to add a separator
function add_separator {
    echo "--------------------------------------------------------------------------------" >> $OUTPUT_FILE
}

# Read .gitignore and combine with custom ignore patterns
IGNORE_PATTERNS=()
if [ -f "$GITIGNORE_FILE" ]; then
    while IFS= read -r line; do
        # Skip empty lines and comments in .gitignore
        if [[ ! "$line" =~ ^# ]] && [[ -n "$line" ]]; then
            IGNORE_PATTERNS+=("--exclude=${line}")
        fi
    done < "$GITIGNORE_FILE"
fi

# Add custom ignore patterns
for pattern in "${CUSTOM_IGNORE_PATTERNS[@]}"; do
    IGNORE_PATTERNS+=("--exclude=${pattern}")
done

# Output the project structure using tree
tree -a "${IGNORE_PATTERNS[@]}" > $OUTPUT_FILE

# Add a separator after the structure
add_separator

# Iterate over each file and output its contents
find . -type f "${IGNORE_PATTERNS[@]}" | while read -r file; do
    # Output the file path
    echo "$file" >> $OUTPUT_FILE
    add_separator

    # Output the file contents
    cat "$file" >> $OUTPUT_FILE
    add_separator
done

echo "Result saved in $OUTPUT_FILE"
