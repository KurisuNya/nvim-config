# nvim-config

Full lua nvim config using lazy.nvim as plugin manager.

Welcome to fork!!!

## Screenshots

![dashboard](https://cdn.kurisunya.top/cdn/2/2023/11/6558f585ee90a.png)

![coding](https://cdn.kurisunya.top/cdn/2/2023/11/655ca814dde35.png)

![debugging](https://cdn.kurisunya.top/cdn/2/2023/11/6558f647241f1.png)

## Tips

* Remember to run `:checkhealth` and fix the errors.

* If you are Winodws user, make sure `im-selcet` is available in your environment path.

There is the link of [im-select](https://github.com/daipeihust/im-select).

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
│   │   │   ├── diffview.lua
│   │   │   ├── easy-action.lua
│   │   │   ├── fast-snip.lua
│   │   │   ├── git-messenger.lua
│   │   │   ├── gitsigns.lua
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
│   │   │   ├── nvim-tinygit.lua
│   │   │   ├── nvim-toggler.lua
│   │   │   ├── telescope.lua
│   │   │   ├── toggleterm.lua
│   │   │   └── troubles.lua
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
│       │   ├── diffview_custom.lua
│       │   ├── diffview.lua
│       │   ├── git-messenger.lua
│       │   ├── init.lua
│       │   ├── neo-tree.lua
│       │   ├── nvim-spectre.lua
│       │   ├── nvim-toggler.lua
│       │   ├── telescope.lua
│       │   └── toggleterm.lua
│       └── ui
│           ├── barbar.lua
│           ├── icons.lua
│           ├── indent-blankline.lua
│           ├── init.lua
│           ├── lualine.lua
│           ├── noice.lua
│           ├── nvim-pqf.lua
│           ├── nvim-web-devicons.lua
│           └── pretty-fold.lua
└── README.md
```
