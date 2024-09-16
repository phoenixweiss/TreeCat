#!/bin/bash

# Output file name
OUTPUT_FILE="output.txt"

# Path to .gitignore and additional ignore patterns
GITIGNORE_FILE=".gitignore"
CUSTOM_IGNORE_PATTERNS=("$OUTPUT_FILE" "$GITIGNORE_FILE" "*.log" "*.tmp" "*.backup" "treecat.sh" ".git")

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
      IGNORE_PATTERNS+=("$line")
    fi
  done < "$GITIGNORE_FILE"
fi

# Add custom ignore patterns
for pattern in "${CUSTOM_IGNORE_PATTERNS[@]}"; do
  IGNORE_PATTERNS+=("$pattern")
done

# Combine all ignore patterns into a regex for tree
TREE_IGNORE_PATTERN=$(printf "|%s" "${IGNORE_PATTERNS[@]}")
TREE_IGNORE_PATTERN="${TREE_IGNORE_PATTERN:1}"  # Remove leading |

# Output the project structure using tree, with -I to exclude patterns
tree -a -I "$TREE_IGNORE_PATTERN" > $OUTPUT_FILE

# Add a separator after the structure
add_separator

# Build the find command with ignore patterns using -prune
FIND_PRUNE=""
for pattern in "${IGNORE_PATTERNS[@]}"; do
  FIND_PRUNE+=" -name \"${pattern}\" -prune -o"
done

# Execute find command with the built prune patterns
eval "find . \( ${FIND_PRUNE} -type f -print \)" | while read -r file; do
  # Output the file path
  echo "$file" >> $OUTPUT_FILE
  add_separator

  # Output the file contents
  cat "$file" >> $OUTPUT_FILE

  # Check if the last character is a newline
  if [ "$(tail -c 1 "$file")" != "" ]; then
    # If not, add a newline before the separator
    echo "" >> $OUTPUT_FILE
  fi

  add_separator
done

echo "Result saved in $OUTPUT_FILE"
