# Installation Guide

## Prerequisites

### Required Dependencies
- **Git**: Version control system
- **Node.js**: For LSP servers and tools (v16+ recommended)
- **Python 3**: For Python development support (3.8+ recommended)
- **Ripgrep (rg)**: Fast text search for Telescope
- **fd**: Fast file finder for Telescope

### Optional Dependencies
- **Stylua**: Lua code formatter
- **Selene**: Lua linter
- **Python packages**: `black`, `isort` for Python formatting

## Installation Steps

### 1. Backup Existing Configuration
```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### 2. Clone This Configuration
```bash
git clone https://github.com/KurisuNya/nvim-config ~/.config/nvim
```

### 3. First Launch
```bash
nvim
```

On first launch:
- Lazy.nvim will automatically install all plugins
- LSP servers will be installed via Mason
- This may take a few minutes

### 4. Verify Installation
Inside Neovim, run:
```vim
:checkhealth
:Lazy
:Mason
```

## Configuration

### Basic Configuration
Edit `lua/config.lua` to customize:
- `default_colorscheme`: Change default theme
- `workspaces`: Add your project directories
- `enable_copilot`: Enable/disable GitHub Copilot
- `format_on_save`: Enable/disable format on save

### Language Support
Language-specific configurations are in `lua/plugins/language/lang/`:
- Python: Pyright LSP, Black formatter, DAP debugging
- Lua: Enhanced Lua development with lazydev
- Markdown: Live preview and table editing
- And more...

### Keybindings
Default leader key is `<Space>`. Key mappings are organized by category:
- `<leader>f`: File/Find operations
- `<leader>g`: Git operations  
- `<leader>l`: LSP operations
- `<leader>d`: Debug operations
- `<leader>t`: Terminal/Test operations

## Troubleshooting

### Common Issues

#### 1. Plugin Installation Fails
```vim
:Lazy clear
:Lazy restore
```

#### 2. LSP Not Working
```vim
:LspInfo
:Mason
```
Check if LSP server is installed in Mason.

#### 3. Telescope Not Finding Files
Ensure `rg` and `fd` are installed:
```bash
# Ubuntu/Debian
sudo apt install ripgrep fd-find

# macOS
brew install ripgrep fd

# Arch Linux
sudo pacman -S ripgrep fd
```

#### 4. Python Support Issues
Install Python development tools:
```bash
pip install black isort pyright
```

### Health Check
Run the built-in health check:
```lua
:lua require("utils.health").check_all()
```

## Support

For issues and questions:
1. Check existing GitHub issues
2. Review the configuration files in `lua/`
3. Use `:help` for Neovim documentation
4. Consult plugin-specific documentation