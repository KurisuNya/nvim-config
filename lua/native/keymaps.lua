local keymap = vim.keymap
local norm_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, silent = true, expr = true }
local desc_opts = function(opts, desc)
	return vim.tbl_extend("force", opts, { desc = desc })
end
local del_maps = function(keys)
	for _, key in ipairs(keys) do
		keymap.set({ "n", "x" }, key, "", norm_opts)
	end
end

vim.g.mapleader = " " -- Leader key
vim.g.maplocalleader = "," -- Local leader key
del_maps({ "q", "Q", "m", "M" })

-- move
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", expr_opts)
keymap.set({ "n", "x" }, "J", "5gj", norm_opts)
keymap.set({ "n", "x" }, "K", "5gk", norm_opts)
keymap.set({ "n", "x" }, "<S-Down>", "5gj", norm_opts)
keymap.set({ "n", "x" }, "<S-Up>", "5gk", norm_opts)

-- save and quit
keymap.set("n", "<leader>w", "<CMD>w<CR>", desc_opts(norm_opts, "Save"))
keymap.set("n", "<leader>q", "<CMD>q<CR>", desc_opts(norm_opts, "Quit"))

-- macro
keymap.set("n", "M", "q", desc_opts(norm_opts, "Record macro"))

-- join lines
keymap.set({ "n", "x" }, "<leader>j", "J", desc_opts(norm_opts, "Join Lines"))

-- add and sub
keymap.set({ "n", "x" }, "+", "<C-a>", norm_opts)
keymap.set({ "n", "x" }, "-", "<C-x>", norm_opts)
keymap.set({ "n", "x" }, "g+", "g<C-a>", norm_opts)
keymap.set({ "n", "x" }, "g-", "g<C-x>", norm_opts)

-- indent
keymap.set("x", "<", "<gv", norm_opts)
keymap.set("x", ">", ">gv", norm_opts)

-- normal mode commands
keymap.set("x", "<leader>n", ":normal ")

-- diff
keymap.set("n", "<leader>dd", function()
	if vim.api.nvim_get_option_value("diff", {}) then
		vim.cmd("windo diffoff")
	else
		vim.cmd("windo diffthis")
	end
end, desc_opts(norm_opts, "Diff Toggle"))

-- split
keymap.set("n", "<leader><Right>", function()
	local splitright = vim.opt_local.splitright
	vim.opt_local.splitright = true
	vim.cmd("vsp")
	vim.opt_local.splitright = splitright
end, desc_opts(norm_opts, "Vertical Split (Right)"))
keymap.set("n", "<leader><Left>", function()
	local splitright = vim.opt_local.splitright
	vim.opt_local.splitright = false
	vim.cmd("vsp")
	vim.opt_local.splitright = splitright
end, desc_opts(norm_opts, "Vertical Split (Left)"))
keymap.set("n", "<leader><Down>", function()
	local splitbelow = vim.opt_local.splitbelow
	vim.opt_local.splitbelow = true
	vim.cmd("sp")
	vim.opt_local.splitbelow = splitbelow
end, desc_opts(norm_opts, "Horizontal Split (Below)"))
keymap.set("n", "<leader><Up>", function()
	local splitbelow = vim.opt_local.splitbelow
	vim.opt_local.splitbelow = false
	vim.cmd("sp")
	vim.opt_local.splitbelow = splitbelow
end, desc_opts(norm_opts, "Horizontal Split (Above)"))
keymap.set("n", "<C-Left>", "<C-w>h", norm_opts)
keymap.set("n", "<C-Down>", "<C-w>j", norm_opts)
keymap.set("n", "<C-Up>", "<C-w>k", norm_opts)
keymap.set("n", "<C-Right>", "<C-w>l", norm_opts)
