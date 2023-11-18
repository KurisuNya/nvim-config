# nvim-config

Full lua nvim config.

Use lazy.nvim as plugin manager.

## Screenshots

![dashboard](https://cdn.kurisunya.top/cdn/2/2023/11/6558f585ee90a.png)

![coding](https://cdn.kurisunya.top/cdn/2/2023/11/6558f5e52a7d4.png)

![debugging](https://cdn.kurisunya.top/cdn/2/2023/11/6558f647241f1.png)

## Project structure

```text
.
├── init.lua
├── lazy-lock.json
├── LICENSE
├── lua
│   ├── core
│   │   ├── autocommand.lua
│   │   ├── colorscheme.lua
│   │   ├── keymaps
│   │   │   ├── barbar.lua
│   │   │   ├── camelcase.lua
│   │   │   ├── easy-action.lua
│   │   │   ├── fast-snip.lua
│   │   │   ├── icon-picker.lua
│   │   │   ├── lspconfig.lua
│   │   │   ├── markdown-preview.lua
│   │   │   ├── neo-tree.lua
│   │   │   ├── nvim-cmp.lua
│   │   │   ├── nvim-dap.lua
│   │   │   ├── nvim-dap-ui.lua
│   │   │   ├── nvim.lua
│   │   │   ├── nvim-navbuddy.lua
│   │   │   ├── nvim-picgo.lua
│   │   │   ├── nvim-spectre.lua
│   │   │   ├── nvim-toggler.lua
│   │   │   ├── telescope.lua
│   │   │   ├── troubles.lua
│   │   │   └── vgit.lua
│   │   └── options.lua
│   └── plugins
│       ├── cmp
│       │   ├── init.lua
│       │   └── nvim-cmp.lua
│       ├── init.lua
│       ├── lsp
│       │   ├── init.lua
│       │   ├── lspconfig.lua
│       │   ├── lspsaga.lua
│       │   ├── mason-lspconfig.lua
│       │   ├── mason-null-ls.lua
│       │   ├── mason-nvim-dap.lua
│       │   ├── null-ls.lua
│       │   ├── nvim-dap-ui.lua
│       │   ├── nvim-jdtls.lua
│       │   ├── nvim-navbuddy.lua
│       │   └── nvim-treesitter.lua
│       ├── tool
│       │   ├── alpha-nvim.lua
│       │   ├── init.lua
│       │   ├── neo-tree.lua
│       │   ├── nvim-spectre.lua
│       │   ├── nvim-toggler.lua
│       │   └── telescope.lua
│       └── ui
│           ├── barbar.lua
│           ├── icons.lua
│           ├── indent-blankline.lua
│           ├── init.lua
│           ├── lualine.lua
│           ├── noice.lua
│           ├── nvim-web-devicons.lua
│           └── pretty-fold.lua
└── README.md
```
