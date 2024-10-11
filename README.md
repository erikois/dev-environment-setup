# Vim and tmux Development Environment Setup

This project provides a streamlined setup for a Vim and tmux-based development environment, focusing on Markdown, JavaScript (including Node.js and React), and Python 
development.

## Features

- Customized Vim configuration with plugins for enhanced productivity
- Tailored tmux configuration for improved terminal management
- Automated setup script for easy installation and configuration
- Support for JavaScript, Python, and Markdown development

## Prerequisites

- Git
- Curl
- Vim (version 8.0 or later recommended)
- tmux (version 2.9 or later recommended)

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/erikois/dev-environment-setup.git
   cd dev-environment-setup
   ```

2. Run the setup script:
   ```
   ./setup.sh
   ```

   The script will guide you through the installation process, asking for confirmation at each step.

## What's Included

### Vim Configuration

- Plugin management with vim-plug
- File exploration with NERDTree
- Fuzzy finding with fzf
- Git integration with vim-fugitive and vim-gitgutter
- Auto-completion and language server protocol support with coc.nvim
- Markdown preview
- JavaScript and React syntax highlighting and indentation
- Python syntax highlighting and PEP 8 indentation

### tmux Configuration

- Custom key bindings for improved workflow
- Mouse support
- Easy window and pane navigation
- Integration with system clipboard
- Smart pane switching with awareness of Vim splits

## Usage

After installation, you can start using Vim and tmux with the new configurations immediately. Here are some key features:

- In Vim:
  - Use `<space>` as the leader key
  - Press `<space>n` to toggle NERDTree
  - Press `<space>f` to search for files
  - Use `gd` to go to definition (when using coc.nvim)

- In tmux:
  - Use `Ctrl-a` as the prefix key
  - Use `prefix |` to split vertically and `prefix -` to split horizontally
  - Use `Alt + arrow keys` to navigate between panes

For more details, refer to the comments in the `.vimrc` and `.tmux.conf` files.

## Customization

Feel free to modify the `.vimrc` and `.tmux.conf` files to suit your preferences. After making changes, you can:

- For Vim: Source the file with `:source ~/.vimrc` or restart Vim
- For tmux: Source the file with `tmux source-file ~/.tmux.conf` or restart tmux

## Troubleshooting

If you encounter any issues, please check the following:

1. Ensure all prerequisites are installed and up to date
2. Check that Node.js is installed and the correct version (v20) is active
3. In Vim, run `:checkhealth` to diagnose potential problems

If problems persist, please open an issue on the GitHub repository.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).
