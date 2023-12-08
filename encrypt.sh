#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <folder_path> <encryption_password>"
    exit 1
fi

folder_path="$1"
encryption_password="$2"

if [ ! -d "$folder_path" ]; then
    echo "Error: Folder does not exist."
    exit 1
fi
absolute_path=$(realpath "$folder_path")
cd "$(dirname "$absolute_path")" || exit 1

folder_name=$(basename "$absolute_path")
zip -r "${folder_name}.zip" "$folder_name"

openssl enc -aes-256-cbc -salt -pbkdf2 -in "${folder_name}.zip" -out "${folder_name}_encrypted.zip" -k "$encryption_password"
rm "${folder_name}.zip"

echo "Encrypted zip file created: ${folder_name}_encrypted.zip"
