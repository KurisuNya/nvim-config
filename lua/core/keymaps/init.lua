-------------------
--  nvim-keymap  --
-------------------
require("core.keymaps.nvim")
--------------------
-- plugin-keymap  --
--------------------
----  direct  ----
require("core.keymaps.barbar")
require("core.keymaps.camelcase")
require("core.keymaps.diffview")
require("core.keymaps.gitsigns")
require("core.keymaps.markdown-preview")
require("core.keymaps.neo-tree")
require("core.keymaps.nvim-dap")
require("core.keymaps.nvim-picgo")
require("core.keymaps.nvim-toggler")
require("core.keymaps.telescope")
require("core.keymaps.troubles")
----  by return  ----
local plugin_keymap = {} --start
plugin_keymap.better_escape = require("core.keymaps.better-escape")
plugin_keymap.hop = require("core.keymaps.hop")
plugin_keymap.lspconfig = require("core.keymaps.lspconfig")
plugin_keymap.nvim_cmp = require("core.keymaps.nvim-cmp")
plugin_keymap.nvim_dap_ui = require("core.keymaps.nvim-dap-ui")
plugin_keymap.nvim_spectre = require("core.keymaps.nvim-spectre")
plugin_keymap.telescope_undo = require("core.keymaps.telescope-undo")
return plugin_keymap --end
