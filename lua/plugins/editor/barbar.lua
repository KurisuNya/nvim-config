M = {
	"romgrk/barbar.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

local gen_key = function(key)
	return { key[1], key[2], desc = key.desc, mode = "n", noremap = true, silent = true }
end

local map_key = function(key)
	vim.api.nvim_set_keymap(key.mode, key[1], key[2], {
		silent = key.silent,
		noremap = key.noremap,
		desc = key.desc,
	})
end

local del_key = function(key)
	vim.api.nvim_del_keymap(key.mode, key[1])
end

local keys = {
	gen_key({ "<A-l>", "<Cmd>BufferNext<CR>", desc = "Buffer Next" }),
	gen_key({ "<A-h>", "<Cmd>BufferPrevious<CR>", desc = "Buffer Previous" }),
	gen_key({ "<A-j>", "<Cmd>BufferNext<CR>", desc = "Buffer Next" }),
	gen_key({ "<A-k>", "<Cmd>BufferPrevious<CR>", desc = "Buffer Previous" }),
	gen_key({ "<A-Right>", "<Cmd>BufferNext<CR>", desc = "Buffer Next" }),
	gen_key({ "<A-Left>", "<Cmd>BufferPrevious<CR>", desc = "Buffer Previous" }),
	gen_key({ "<A-Down>", "<Cmd>BufferNext<CR>", desc = "Buffer Next" }),
	gen_key({ "<A-Up>", "<Cmd>BufferPrevious<CR>", desc = "Buffer Previous" }),

	gen_key({ "<A-,>", "<Cmd>BufferMovePrevious<CR>", desc = "Buffer Move to Previous" }),
	gen_key({ "<A-.>", "<Cmd>BufferMoveNext<CR>", desc = "Buffer Move to Next" }),
	gen_key({ "<A-s>", "<Cmd>BufferOrderByDirectory<CR>", desc = "Buffer Sort by Dir" }),

	gen_key({ "<A-p>", "<Cmd>BufferPin<CR>", desc = "Buffer Pin" }),
	gen_key({ "<A-q>", "<Cmd>BufferClose<CR>", desc = "Buffer Close" }),
	gen_key({ "<A-Q>", "<Cmd>BufferCloseAllButPinned<CR>", desc = "Buffer Close Except Pinned" }),
}

local map_barbar_keys = function()
	for _, key in ipairs(keys) do
		map_key(key)
	end
end

local del_barbar_keys = function()
	for _, key in ipairs(keys) do
		del_key(key)
	end
end

M.keys = map_barbar_keys

M.init = function()
	vim.g.barbar_auto_setup = false
	vim.opt.showtabline = 0
	PluginVars.insert(PluginVars.diffview_open_hooks, del_barbar_keys)
	PluginVars.insert(PluginVars.diffview_close_hooks, map_barbar_keys)
end

M.config = function()
	local opts = {
		animation = false,
		tabpages = false,
		highlight_visible = true,
		modified = { button = Icons.git.Modified },
		focus_on_close = "left",
		icons = {
			diagnostics = {
				[vim.diagnostic.severity.ERROR] = { enabled = true, icon = Icons.diagnostics.Error },
				[vim.diagnostic.severity.WARN] = { enabled = true, icon = Icons.diagnostics.Warning },
				[vim.diagnostic.severity.INFO] = { enabled = true, icon = Icons.diagnostics.Info },
				[vim.diagnostic.severity.HINT] = { enabled = true, icon = Icons.diagnostics.Hint },
			},
			separator_at_end = false,
			separator = { left = "▎", right = "" },
			visible = { separator = { left = "▎", right = "" } },
			inactive = { separator = { left = " ", right = "" } },
			pinned = { button = Icons.ui.pinned, filename = true },
		},
		maximum_padding = 1,
		minimum_padding = 1,
		no_name_title = "Empty",
	}

	if Utils.plugin_exists("neo-tree.nvim") then
		opts.sidebar_filetypes = {
			["neo-tree"] = { event = "BufWipeout", text = "FILE EXPLORER" },
		}
	end
	require("barbar").setup(opts)
end
return M
