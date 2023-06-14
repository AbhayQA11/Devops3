#!/bin/bash

get_encrypted_password() {
    local password="$1"
    local algorithm="$2"
    local encrypted_password

    case "$algorithm" in
        md5)
            encrypted_password=$(echo -n "$password" | md5sum | awk '{print $1}')
            ;;
        sha1)
            encrypted_password=$(echo -n "$password" | sha1sum | awk '{print $1}')
            ;;
        sha256)
            encrypted_password=$(echo -n "$password" | sha256sum | awk '{print $1}')
            ;;
        sha512)
            encrypted_password=$(echo -n "$password" | sha512sum | awk '{print $1}')
            ;;
        bcrypt)
            if [ ${#password} -gt 8 ]; then
                password="${password:0:8}"
                echo "Warning: truncating password to 8 characters"
            fi
            encrypted_password=$(openssl passwd -crypt "$password")
            ;;
        *)
            echo "Invalid algorithm"
            return 1
            ;;
    esac

    echo "$encrypted_password"
}

get_named_argument() {
    local password="$1"
    local named_argument="$2"

    case "$named_argument" in
        --algo)
            get_encrypted_password "$password" "$3"
            ;;
        --text)
            echo "Text: $password"
            ;;
        --length)
            echo "Length: ${#password}"
            ;;
        *)
            echo "Invalid named argument"
            ;;
    esac
}

# Retrieve the arguments
password="$1"
named_argument="$2"

# Get the encrypted password or named argument result
if [[ -n "$named_argument" ]]; then
    if [[ "$named_argument" == "--algo" ]]; then
        algorithm="$3"
        encrypted_password=$(get_encrypted_password "$password" "$algorithm")
        echo "Encrypted password: $encrypted_password"
		echo "Algo: $3"
    else
        get_named_argument "$password" "$named_argument" "$3"
    fi
else
    encrypted_password=$(get_encrypted_password "$password" "md5")
    echo "Encrypted password: $encrypted_password"
fi
