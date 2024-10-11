#!/bin/bash

set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to prompt user for confirmation
confirm() {
    read -r -p "${1:-Are you sure?} [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

# Check and install required packages
install_packages() {
    echo "Checking and installing required packages..."
    if command_exists apt-get; then
        sudo apt-get update
        sudo apt-get install -y vim tmux git curl
    elif command_exists brew; then
        brew install vim tmux git curl
    else
        echo "Unable to install packages. Please install vim, tmux, git, and curl manually."
        exit 1
    fi
}

# Setup Vim configuration
setup_vim() {
    echo "Setting up Vim..."
    if [ -f ~/.vimrc ]; then
        if confirm "Existing .vimrc found. Do you want to back it up and replace it?"; then
            mv ~/.vimrc ~/.vimrc.backup
            echo "Existing .vimrc backed up to ~/.vimrc.backup"
        else
            echo "Skipping .vimrc setup"
            return
        fi
    fi
    curl -fLo ~/.vimrc https://raw.githubusercontent.com/erikois/vim-config/master/.vimrc
    
    # Install vim-plug
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # Ensure gruvbox color scheme is installed
    if ! grep -q "Plug 'morhetz/gruvbox'" ~/.vimrc; then
        echo "Adding gruvbox plugin to .vimrc"
        echo "call plug#begin('~/.vim/plugged')" >> ~/.vimrc
        echo "Plug 'morhetz/gruvbox'" >> ~/.vimrc
        echo "call plug#end()" >> ~/.vimrc
    fi

    # Install plugins
    vim +PlugInstall +qall
}

# Setup tmux configuration
setup_tmux() {
    echo "Setting up tmux..."
    if [ -f ~/.tmux.conf ]; then
        if confirm "Existing .tmux.conf found. Do you want to back it up and replace it?"; then
            mv ~/.tmux.conf ~/.tmux.conf.backup
            echo "Existing .tmux.conf backed up to ~/.tmux.conf.backup"
        else
            echo "Skipping .tmux.conf setup"
            return
        fi
    fi
    curl -fLo ~/.tmux.conf https://raw.githubusercontent.com/erikois/tmux-config/master/.tmux.conf
}

# Setup Node.js with nvm
setup_node() {
    echo "Setting up Node.js with nvm..."
    if command_exists nvm; then
        echo "nvm is already installed"
    else
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    fi
    
    nvm install 20
    nvm use 20
    nvm alias default 20
}

# Main script execution
echo "Starting setup..."

if confirm "Do you want to install/update required packages?"; then
    install_packages
fi

if confirm "Do you want to set up Vim configuration?"; then
    setup_vim
fi

if confirm "Do you want to set up tmux configuration?"; then
    setup_tmux
fi

if confirm "Do you want to set up Node.js with nvm?"; then
    setup_node
fi

echo "Setup completed successfully!"
echo "Please restart your terminal or run 'source ~/.bashrc' (or equivalent for your shell) to apply changes."
