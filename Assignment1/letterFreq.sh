#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Error: Input file not provided as command line argument."
  exit 1
fi

file="$1"

if [ ! -f "$file" ]; then
  echo "Error: File '$file' not found."
  exit 1
fi

# Read the file, remove punctuation, convert to lowercase, and split into words
words=$(tr -d '[:punct:]' < "$file" | tr '[:upper:]' '[:lower:]' | tr ' ' '\n')

# Calculate the frequency of each word
declare -A frequencies
for word in $words; do
  frequencies[$word]=$(( frequencies[$word] + 1 ))
done

# Sort the words by descending frequency
sorted_words=$(for word in "${!frequencies[@]}"; do
  echo "$word ${frequencies[$word]}"
done | sort -rn -k2)

# Output the results
while read -r line; do
  echo "$line"
done <<< "$sorted_words"
