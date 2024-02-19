#!/bin/sh

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 (--install-deps) <cidr-range>"
    exit 1
fi

if [ "$1" = "--install-deps" ]; then
    echo "[+] Installing dependencies"

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if lsb_release -a 2>/dev/null | grep -q 'Debian'; then
            sudo apt-get update && sudo apt-get install -y nmap
        elif lsb_release -a 2>/dev/null | grep -q 'Fedora'; then
            sudo dnf install -y nmap
        elif lsb_release -a 2>/dev/null | grep -q 'Arch\|Manjaro'; then
            sudo pacman -Syu nmap
        fi
    fi

    cidr="$2"
else
    cidr="$1"
fi

nmap -sS -T4 -A $cidr -oN nmap.log -oX nmap.xml