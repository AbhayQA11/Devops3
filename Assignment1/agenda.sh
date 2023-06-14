#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Error: Agenda file not provided as command line argument."
  exit 1
fi

agenda_file="$1"

if [ ! -f "$agenda_file" ]; then
  echo "Error: File '$agenda_file' not found."
  exit 1
fi

current_date=$(date +%d.%m.%Y)
next_date=$(date -d "+1 day" +%d.%m.%Y)

echo "Current Date: $current_date"
echo "Next Date: $next_date"

echo "Meeting Schedule:"
echo "-----------------"
echo "Date       | Meeting"
echo "-----------------"

date=""
print_meeting=false

while IFS= read -r line; do
  # Convert the line to lowercase for easier matching
  lowercase_line=$(echo "$line" | tr '[:upper:]' '[:lower:]')

  if [[ $lowercase_line =~ [0-9]{1,2}\ [a-zA-Z]+\ [0-9]{4} ]]; then
    date=$(date -d "$line" +%d.%m.%Y)
  elif [[ $lowercase_line == *"$current_date"* || $lowercase_line == *"$next_date"* ]]; then
    printf "%-11s| %s\n" "$date" "$line"
  fi
done < "$agenda_file"
