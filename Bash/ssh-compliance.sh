#!/bin/sh

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 (--install-deps) (--docker) <file-with-hosts>"
    exit 1
fi

if [ "$1" = "--install-deps" ]; then
    echo "[+] Installing dependencies"

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if lsb_release -a 2>/dev/null | grep -q 'Debian'; then
            sudo apt-get update && sudo apt-get install -y ssh-audit || pip3 install --upgrade ssh-audit
        elif lsb_release -a 2>/dev/null | grep -q 'Fedora'; then
            sudo dnf install -y ssh-audit || pip3 install --upgrade ssh-audit
        elif lsb_release -a 2>/dev/null | grep -q 'Arch\|Manjaro'; then
            sudo pacman -Syu ssh-audit || pip3 install --upgrade ssh-audit
        fi
    else
        pip3 install --upgrade ssh-audit
    fi

    filename="$2"
else
    filename="$1"
fi

if [ "$1" = "--docker" ]; then
    echo "[-] Pulling Image"
    sudo docker pull positronsecurity/ssh-audit

    echo "[-] Running Image"
    docker run -it -p 2222:2222 positronsecurity/ssh-audit

    echo "[+] SSH Audit Server Accessible at Port 2222"

    exit 0
fi

if [ ! -f "$filename" ]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

ssh-audit -T $1 | tee ssh.log