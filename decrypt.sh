#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <encrypted_zip_path> <decryption_password>"
    exit 1
fi

encrypted_zip_path="$1"
decryption_password="$2"

if [ ! -f "$encrypted_zip_path" ]; then
    echo "Error: Encrypted file does not exist."
    exit 1
fi

absolute_path=$(realpath "$encrypted_zip_path")

cd "$(dirname "$absolute_path")" || exit 1

file_name=$(basename -- "$encrypted_zip_path")
file_name_no_ext="${file_name%.*}"

openssl enc -d -aes-256-cbc -salt -pbkdf2 -in "$file_name" -out "${file_name_no_ext}_decrypted.zip" -k "$decryption_password"

echo "Decrypted zip file created: ${file_name_no_ext}_decrypted.zip"
