#!/usr/bin/env bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[*]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[+]${NC} $1"
}

print_error() {
    echo -e "${RED}[-]${NC} $1"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# For now, it just assumes Ubuntu if not MacOs.
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "ubuntu"
    fi
}

# Install Ansible if not present
install_ansible() {
    if ! command_exists ansible; then
        print_status "Installing Ansible..."
        case $(detect_os) in
            "macos")
                if ! command_exists brew; then
                    print_error "Homebrew is not installed. Please install it first."
                    exit 1
                fi
                brew install ansible
                ;;
            "ubuntu")
                sudo apt update
                sudo apt install -y ansible
                ;;
        esac
    fi
}

main() {
    print_status "Starting dotfiles installation..."

    # Check if Git is installed
    if ! command_exists git; then
        print_error "Git is not installed. Please install it first."
        exit 1
    fi

    # Check if running on supported OS
    OS=$(detect_os)

    # Install Ansible if needed
    install_ansible

    # Install zsh if not present
    if ! command_exists zsh; then
        print_status "Installing zsh..."
        case $OS in
            "macos")
                brew install zsh
                ;;
            "ubuntu")
                sudo apt install -y zsh
                ;;
        esac
    fi

    # Set zsh as default shell
    if [[ $SHELL != *"zsh"* ]]; then
        print_status "Setting zsh as default shell..."
        sudo chsh -s $(which zsh) $USER
    fi

    # Ensure we're in the script's directory
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    cd "$SCRIPT_DIR"

    print_status "Running Ansible playbook..."
    ansible-playbook site.yml

    print_success "Installation completed successfully!"
    print_status "Please restart your shell or run 'source ~/.zshrc' to load the new configuration."
}

main
