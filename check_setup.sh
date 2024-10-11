#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check file difference
file_differs() {
    if [ ! -f "$2" ]; then
        return 0
    fi
    diff "$1" "$2" >/dev/null 2>&1
    return $?
}

# Check Vim
check_vim() {
    if ! command_exists vim; then
        echo "Vim is not installed."
        return 1
    fi
    if file_differs ".vimrc" "$HOME/.vimrc"; then
        echo "Vim configuration differs or doesn't exist."
        return 1
    fi
    echo "Vim setup looks good."
    return 0
}

# Check tmux
check_tmux() {
    if ! command_exists tmux; then
        echo "tmux is not installed."
        return 1
    fi
    if file_differs ".tmux.conf" "$HOME/.tmux.conf"; then
        echo "tmux configuration differs or doesn't exist."
        return 1
    fi
    echo "tmux setup looks good."
    return 0
}

# Check Node.js and nvm
check_node() {
    if ! command_exists node; then
        echo "Node.js is not installed."
        return 1
    fi

    local node_version=$(node -v)
    if [[ "$node_version" != "v20"* ]]; then
        echo "Node.js version is not 20.x (current: $node_version)."
        return 1
    fi

    if ! command_exists nvm; then
        echo "Node.js v$node_version is installed, but not through nvm."
        echo "Consider installing nvm for better Node.js version management."
        return 1
    fi

    if [ ! -d "$HOME/.nvm" ]; then
        echo "nvm directory not found. nvm might not be properly installed."
        return 1
    fi

    local nvm_node_path=$(nvm which current 2>/dev/null)
    if [ -z "$nvm_node_path" ]; then
        echo "Node.js is installed, but not managed by nvm."
        return 1
    fi

    echo "Node.js setup with nvm looks good."
    return 0
}

# Main check
main_check() {
    local setup_needed=0

    check_vim || setup_needed=1
    check_tmux || setup_needed=1
    check_node || setup_needed=1

    if [ $setup_needed -eq 1 ]; then
        echo "Setup or update is recommended."
    else
        echo "All systems are properly configured. No setup needed."
    fi
}

main_check
