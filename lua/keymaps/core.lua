local keymap = vim.keymap
local opts = { noremap = true, silent = true }
-- disband keymaps
keymap.set({ "n", "x" }, "q", "", opts)
keymap.set({ "n", "x" }, "Q", "", opts)
keymap.set({ "n", "x" }, "ZZ", "", opts)
---------------------
--   better-move   --
---------------------
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "J", "5gj", opts)
keymap.set({ "n", "x" }, "K", "5gk", opts)
keymap.set({ "n", "x" }, "<S-Down>", "5gj", opts)
keymap.set({ "n", "x" }, "<S-Up>", "5gk", opts)
--------------------
--   normal-mod   --
--------------------
-- save and quit
keymap.set("n", "<leader>w", "<Cmd>w<CR>", {
	noremap = true,
	silent = true,
	desc = "Save",
})
keymap.set("n", "<leader>q", "<Cmd>q<CR>", {
	noremap = true,
	silent = true,
	desc = "Quit",
})
keymap.set("n", "<leader>W", "<Cmd>wq<CR>", {
	noremap = true,
	silent = true,
	desc = "Save Quit",
})
keymap.set("n", "<leader>Q", "<Cmd>q!<CR>", {
	noremap = true,
	silent = true,
	desc = "Force Quit",
})
-- record macro
keymap.set("n", "<leader>M", "q", {
	noremap = true,
	silent = true,
	desc = "Record Marco",
})
-- window operation
keymap.set("n", "<leader><Right>", "<Cmd>vsp<CR>", {
	noremap = true,
	silent = true,
	desc = "Vertical Spilt Window",
})
keymap.set("n", "<leader><Down>", "<Cmd>sp<CR>", {
	noremap = true,
	silent = true,
	desc = "Horizontal Spilt Window",
})
keymap.set("n", "<C-Left>", "<C-w>h", opts)
keymap.set("n", "<C-Down>", "<C-w>j", opts)
keymap.set("n", "<C-Up>", "<C-w>k", opts)
keymap.set("n", "<C-Right>", "<C-w>l", opts)
-- line operation
keymap.set("n", "<leader>j", "J", {
	noremap = true,
	silent = true,
	desc = "Joint Lines",
})
-- add and sub
keymap.set("n", "+", "<C-a>", opts)
keymap.set("n", "_", "<C-x>", opts)
--------------------
--   visual-mod   --
--------------------
-- add and sub
keymap.set("x", "+", "<C-a>", opts)
keymap.set("x", "_", "<C-x>", opts)
keymap.set("x", "g+", "g<C-a>", opts)
keymap.set("x", "g_", "g<C-x>", opts)
-- better indent
keymap.set("x", "<", "<gv")
keymap.set("x", ">", ">gv")
----------------------
--   terminal-mod   --
----------------------
-- window operation
keymap.set("t", "<C-Left>", [[ <C-\><C-N><C-w>h ]], opts)
keymap.set("t", "<C-Down>", [[ <C-\><C-N><C-w>j ]], opts)
keymap.set("t", "<C-Up>", [[ <C-\><C-N><C-w>k ]], opts)
keymap.set("t", "<C-Right>", [[ <C-\><C-N><C-w>l ]], opts)
