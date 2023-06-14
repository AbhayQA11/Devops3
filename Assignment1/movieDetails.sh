#!/bin/bash

# Function to search for movies and display results
search_movies() {
    query=$1
    result=$(grep -i "$query" "$2")

    if [ -z "$result" ]; then
        echo "No matches found for \"$query\"."
    else
        echo "Matches found for \"$query\":"
        echo "$result"
    fi
}

# Prompt the user to enter a movie title
read -p "Enter a movie title: " movie_title

# Specify the path to the movies file
movies_file="./movies.txt"

# Call the search_movies function with the provided movie title and file path
search_movies "$movie_title" "$movies_file"
