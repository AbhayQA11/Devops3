#!/bin/bash

findSubstringIndices() {
    s=$1
    words=("$@")

    if [ -z "$s" ] || [ ${#words[@]} -eq 0 ]; then
        return
    fi

    declare -A wordCount
    for word in "${words[@]}"; do
        ((wordCount[$word]++))
    done

    wordLength=${#words[0]}
    result=()

    for ((i=0; i<wordLength; i++)); do
        left=$i
        declare -A currCount
        numWords=0

        for ((j=i; j<${#s}-wordLength+1; j+=wordLength)); do
            currWord="${s:j:wordLength}"

            if [[ ${wordCount[$currWord]} ]]; then
                ((currCount[$currWord]++))

                if ((currCount[$currWord] <= wordCount[$currWord])); then
                    ((numWords++))
                else
                    while ((currCount[$currWord] > wordCount[$currWord])); do
                        leftWord="${s:left:wordLength}"
                        ((currCount[$leftWord]--))

                        if ((currCount[$leftWord] < wordCount[$leftWord])); then
                            ((numWords--))
                        fi

                        left=$((left+wordLength))
                    done
                fi

                if ((numWords == ${#words[@]})); then
                    result+=($left)
                    leftWord="${s:left:wordLength}"
                    ((currCount[$leftWord]--))
                    ((numWords--))
                    left=$((left+wordLength))
                fi
            else
                currCount=()
                numWords=0
                left=$((j+wordLength))
            fi
        done
    done

    echo "${result[@]}"
}

# Example usage
words=("ab" "cd" "ef")
s="abcdefabefcdefabcd"
indices=$(findSubstringIndices "$s" "${words[@]}")
echo "$indices"
