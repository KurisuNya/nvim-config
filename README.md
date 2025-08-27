# KurisuNya's Neovim Configuration

A highly customized, feature-rich Neovim configuration built for modern development workflows.

## ✨ Features

- 🚀 **Fast Startup**: Optimized with lazy loading and performance tweaks
- 🎨 **Beautiful UI**: Multiple colorschemes with consistent theming
- 📁 **Smart File Management**: Neo-tree, Telescope, and project management
- 🔍 **Powerful Search**: Fuzzy finding with live grep and file preview
- 💻 **Advanced LSP**: Full language server support with intelligent features
- 🐛 **Integrated Debugging**: DAP support for multiple languages
- 🔧 **Git Integration**: Comprehensive Git workflow with visual diff tools
- 🧪 **Testing Support**: Neotest integration for various frameworks
- 🌐 **Multi-Language**: Python, Lua, Markdown, C/C++, and more

## 🚀 Quick Start

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this configuration
git clone https://github.com/KurisuNya/nvim-config ~/.config/nvim

# Launch Neovim (plugins will auto-install)
nvim
```

## 📚 Documentation

- [📦 Installation Guide](docs/installation.md)
- [🔌 Plugin Reference](docs/plugins.md)

## 🎯 Key Bindings

| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>e` | Toggle file explorer |
| `<leader>gg` | Lazy Git |
| `<leader>gd` | Git diff current file |
| `<leader>gD` | Git diff project |

## 🛠️ Configuration

Core settings in `lua/config.lua`:

```lua
M.default_colorscheme = "tokyonight-storm"
M.enable_copilot = true
M.format_on_save = true
M.workspaces = {
    -- Add your project directories here
}
```

## 🔧 Requirements

- **Neovim** ≥ 0.9.0
- **Git**
- **Node.js** (for LSP servers)
- **Python 3** (for Python support)
- **ripgrep** (for telescope search)
- **fd** (for telescope file finding)

## 📊 Project Statistics

- **86 Lua files** across modular structure
- **60+ plugins** organized by category
- **Multi-language support** with dedicated configs
- **Advanced LSP integration** with method-based keymaps

## 🏗️ Architecture

```
nvim-config/
├── init.lua              # Entry point
├── lua/
│   ├── config.lua        # Main configuration
│   ├── native/           # Core Neovim settings
│   ├── utils/            # Utility functions
│   └── plugins/          # Plugin configurations
│       ├── colorscheme/  # Themes
│       ├── editor/       # UI and editing
│       ├── coding/       # Development tools
│       └── language/     # Language support
└── docs/                 # Documentation
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built on top of [lazy.nvim](https://github.com/folke/lazy.nvim)
- Inspired by various community configurations
- Thanks to all plugin authors and maintainers
