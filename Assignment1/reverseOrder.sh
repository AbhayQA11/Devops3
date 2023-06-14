#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Error: Input not provided as command line argument."
  exit 1
fi

input=$1
reverse=""

for (( i=${#input}-1; i>=0; i-- )); do
  reverse="$reverse${input:$i:1}"
done

echo "Reverse value is \"$reverse\""
