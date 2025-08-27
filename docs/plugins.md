# Plugin Reference

This document provides a comprehensive list of all plugins used in this Neovim configuration, organized by category.

## 🎨 Colorschemes

### Tokyo Night
- **Plugin**: `folke/tokyonight.nvim`
- **Purpose**: Modern dark theme with multiple variants
- **Variants**: storm (default), night, moon, day

### Catppuccin
- **Plugin**: `catppuccin/nvim`
- **Purpose**: Soothing pastel theme
- **Variants**: frappe, macchiato, mocha, latte

### Material
- **Plugin**: `marko-cerovac/material.nvim`
- **Purpose**: Material Design inspired theme

### Ayu
- **Plugin**: `Shatur/neovim-ayu`
- **Purpose**: Clean and elegant theme

## 📝 Editor Features

### File Management
- **Neo-tree** (`nvim-neo-tree/neo-tree.nvim`): File explorer with Git integration
- **Telescope** (`nvim-telescope/telescope.nvim`): Fuzzy finder for files, buffers, etc.
- **Projections** (`gnikdroy/projections.nvim`): Project management and session handling

### UI Enhancements
- **Alpha** (`goolord/alpha-nvim`): Customizable start screen
- **Lualine** (`nvim-lualine/lualine.nvim`): Status line
- **Barbar** (`romgrk/barbar.nvim`): Tab bar with buffer management
- **Which Key** (`folke/which-key.nvim`): Key binding hints
- **Dressing** (`stevearc/dressing.nvim`): Better UI for input and select
- **Noice** (`folke/noice.nvim`): Enhanced command line and notifications

### Git Integration
- **Gitsigns** (`lewis6991/gitsigns.nvim`): Git decorations and hunk actions
- **Diffview** (`sindrets/diffview.nvim`): Git diff and merge tool
- **Tinygit** (`chrisgrieser/nvim-tinygit`): Lightweight Git operations
- **Git Conflict** (`akinsho/git-conflict.nvim`): Conflict resolution assistance

### Terminal and Search
- **Toggleterm** (`akinsho/toggleterm.nvim`): Terminal management
- **Grug Far** (`MagicDuck/grug-far.nvim`): Find and replace with preview
- **Quicker** (`stevearc/quicker.nvim`): Enhanced quickfix window

### Utility
- **Sniprun** (`michaelb/sniprun`): Code runner
- **Icon Picker** (`ziontee113/icon-picker.nvim`): Icon selection
- **Snacks** (`folke/snacks.nvim`): Collection of useful utilities
- **Numb** (`nacro90/numb.nvim`): Line number peeking
- **HLSearch** (`asiryk/auto-hlsearch.nvim`): Auto highlight search
- **Stickybuf** (`stevearc/stickybuf.nvim`): Lock buffers to windows

## 💻 Coding Features

### Completion and Snippets
- **nvim-cmp** (`hrsh7th/nvim-cmp`): Completion engine
- **LuaSnip** (`L3MON4D3/LuaSnip`): Snippet engine
- **LSP Signature** (`ray-x/lsp_signature.nvim`): Function signature hints

### Code Navigation and Editing
- **Leap** (`ggandor/leap.nvim`): Fast motion plugin
- **Illuminate** (`RRethy/vim-illuminate`): Highlight word under cursor
- **Surround** (`kylechui/nvim-surround`): Manipulate surrounding characters
- **Toggler** (`nguyenvukhang/nvim-toggler`): Toggle words (true/false, etc.)
- **Auto Pairs** (`echasnovski/mini.pairs`): Automatic bracket pairing
- **Auto Tag** (`windwp/nvim-ts-autotag`): Auto close HTML/XML tags

### Code Formatting and Display
- **Indent Blankline** (`lukas-reineke/indent-blankline.nvim`): Indent guides
- **Indent-o-matic** (`Darazaki/indent-o-matic`): Auto detect indentation
- **Colorizer** (`norcalli/nvim-colorizer.lua`): Color preview
- **Todo Comments** (`folke/todo-comments.nvim`): Highlight TODO comments
- **TS Comments** (`folke/ts-comments.nvim`): Smart commenting
- **Virt Column** (`lukas-reineke/virt-column.nvim`): Virtual column display

## 🔧 Language Support

### Core Language Tools
- **Mason** (`williamboman/mason.nvim`): LSP/DAP/Linter installer
- **LSP Config** (`neovim/nvim-lspconfig`): LSP client configurations
- **LSP Saga** (`nvimdev/lspsaga.nvim`): Enhanced LSP UI
- **Treesitter** (`nvim-treesitter/nvim-treesitter`): Syntax highlighting
- **DAP** (`mfussenegger/nvim-dap`): Debug Adapter Protocol
- **Neotest** (`nvim-neotest/neotest`): Testing framework

### Formatters and Linters
- **None-ls** (`nvimtools/none-ls.nvim`): Null-ls alternative for formatters
- **Formatter** (`mhartington/formatter.nvim`): Code formatting
- **Inlay Hints** (`simrat39/inlay-hints.nvim`): Type hints display

### Language-Specific Plugins

#### Python
- **Pyright**: LSP server for Python
- **Black**: Code formatter
- **DAP Python** (`mfussenegger/nvim-dap-python`): Python debugging
- **Neotest Python** (`nvim-neotest/neotest-python`): Python testing
- **Venv Selector** (`linux-cultist/venv-selector.nvim`): Virtual environment selection

#### Lua
- **Lazydev** (`folke/lazydev.nvim`): Enhanced Lua development for Neovim

#### Markdown
- **Markdown Preview** (`iamcco/markdown-preview.nvim`): Live preview
- **Table Mode** (`dhruvasagar/vim-table-mode`): Table editing
- **Clipboard Image** (`HakonHarnes/img-clip.nvim`): Image pasting

#### Other Languages
- **C/C++**: Clangd LSP support
- **TOML**: Syntax highlighting and LSP
- **XML**: Language support
- **Prettier**: For web development files
- **CSpell**: Spell checking

## 🐧 Linux-Specific

### System Integration
- **Fcitx** (`h-hg/fcitx.nvim`): Input method integration
- **Suda** (`lambdalisue/suda.vim`): Sudo write support

## ⚙️ Configuration Structure

### Plugin Organization
```
plugins/
├── colorscheme/    # Theme configurations
├── editor/         # Editor UI and functionality
├── coding/         # Coding assistance tools
└── language/       # Language-specific features
    └── lang/       # Individual language setups
```

### Key Features
- **Lazy Loading**: Most plugins load on demand
- **Conditional Loading**: OS-specific plugins
- **Unified Configuration**: Consistent setup patterns
- **Cross-Plugin Integration**: Shared variables and settings

## 🔍 Plugin Selection Rationale

### Performance Focus
- Plugins chosen for speed and efficiency
- Lazy loading to minimize startup time
- Native Lua implementations preferred

### Feature Completeness
- Comprehensive development environment
- Language-agnostic core with language-specific extensions
- Modern alternatives to traditional Vim plugins

### Maintainability
- Well-maintained plugins with active development
- Clear documentation and community support
- Minimal configuration overhead