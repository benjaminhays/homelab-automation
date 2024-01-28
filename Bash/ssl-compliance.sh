#!/bin/sh

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 (--install-deps) <file-with-hosts>"
    exit 1
fi

if [ "$1" = "--install-deps" ]; then
    echo "[+] Installing dependencies"
    pip3 install --upgrade pip setuptools wheel --break-system-packages
    pip3 install --upgrade sslyze --break-system-packages
    filename="$2"
else
    filename="$1"
fi

if [ ! -f "$filename" ]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

while IFS= read -r line; do
    python3 -m sslyze "$line"
done < "$filename"
