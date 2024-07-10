#!/bin/bash

# Usage:
# ./3.sh DIRECTORY

show_file_statistics() {
    # Define paramter to variable
    DIRECTORY=$1

    # Validate directory
    if [ ! -d "$DIRECTORY" ]; then
        echo "Error: Directory $DIRECTORY does not exist."
        exit 1
    fi

    # Table header
    printf "%-20s %10s %10s %10s\n" "File" "Lines" "Words" "Chars"
    printf "%-20s %10s %10s %10s\n" "----" "-----" "-----" "-----"

    # Define variables for counting lines, words, and chars
    total_lines=0
    total_words=0
    total_chars=0

    for file in "$DIRECTORY"/*.txt; do
        if [ -f "$file" ]; then
            lines=$(wc -l < "$file")
            words=$(wc -w < "$file")
            chars=$(wc -m < "$file")

            # Shows counting each file
            printf "%-20s %10d %10d %10d\n" "$(basename "$file")" "$lines" "$words" "$chars"

            total_lines=$((total_lines + lines))
            total_words=$((total_words + words))
            total_chars=$((total_chars + chars))
        fi
    done

    # Shows total counting
    printf "%-20s %10s %10s %10s\n" "----" "-----" "-----" "-----"
    printf "%-20s %10d %10d %10d\n" "Total" "$total_lines" "$total_words" "$total_chars"
}

# Validate number of parameters
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 DIRECTORY"
    exit 1
fi

show_file_statistics $1
