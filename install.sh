#!/bin/sh

set -e
set -u

REPO_URL="https://github.com/GuillaumeDorschner/Setup.git"
SETUP_DIR="$HOME/Setup"

OS="$(uname -s)"

install_dependencies() {
    echo "🔍 Checking dependencies..."

    if ! command -v git >/dev/null 2>&1; then
        echo "📥 Installing git..."
        if [ "$OS" = "Darwin" ]; then
            xcode-select --install || echo "✅ Xcode CLI already installed"
        elif [ -f "/etc/debian_version" ]; then
            sudo apt update && sudo apt install -y git
        elif [ -f "/etc/redhat-release" ]; then
            sudo yum install -y git
        fi
    fi

    if ! command -v pip3 >/dev/null 2>&1; then # TODO: check macos works or need to change to pip
        echo "📥 Installing Python & pip..."
        if [ -f "/etc/debian_version" ]; then
            sudo apt update && sudo apt install -y python3 python3-pip python3-venv
        elif [ -f "/etc/redhat-release" ]; then
            sudo yum install -y python3 python3-pip
        fi
    fi

    if ! command -v ansible >/dev/null 2>&1; then
        echo "📥 Installing Ansible..."
        if [ "$OS" = "Darwin" ]; then
            pip3 install ansible # TODO: check macos works or need to change to pip
        elif [ -f "/etc/debian_version" ]; then
            sudo apt update && sudo apt install -y ansible
        elif [ -f "/etc/redhat-release" ]; then
            sudo yum install -y ansible
        fi
    fi
}

setup_ansible() {
    echo "📂 Setting up Ansible repository in $SETUP_DIR..."
    mkdir -p "$SETUP_DIR"
    
    if [ ! -d "$SETUP_DIR/.git" ]; then
        git clone "$REPO_URL" "$SETUP_DIR"
    else
        cd "$SETUP_DIR"
        git pull
    fi
}

run_ansible() {
    echo "🚀 Running Ansible playbook..."
    cd "$SETUP_DIR"
    sudo ansible-playbook -i hosts setup.yml
}

if ! command -v ansible >/dev/null 2>&1; then
    install_dependencies
fi
setup_ansible
run_ansible

echo "✅ Setup completed!"