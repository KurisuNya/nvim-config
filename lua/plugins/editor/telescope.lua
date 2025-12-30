local M = {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
}

local build_cmd ---@type string?
for _, cmd in ipairs({ "make", "cmake", "gmake" }) do
	if vim.fn.executable(cmd) == 1 then
		build_cmd = cmd
		break
	end
end

M.dependencies = {
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = (build_cmd ~= "cmake") and "make"
			or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && "
				.. "cmake --build build --config Release && "
				.. "cmake --install build --prefix build",
	},
}

M.keys = {
	{
		"<leader>ff",
		"<CMD>Telescope find_files<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Find File",
	},
	{
		"<leader>fs",
		"<CMD>Telescope live_grep<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Find String",
	},
	{
		"<leader>fc",
		"<CMD>Telescope git_commits<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Find Commit",
	},
	{
		"<leader>fb",
		"<CMD>Telescope git_branches<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Find Branch",
	},
}

local mappings = function()
	local map = {
		n = {
			["<ESC>"] = "close",
			["q"] = "close",
			["J"] = function(bufnr)
				for _ = 1, 5 do
					require("telescope.actions").move_selection_next(bufnr)
				end
			end,
			["K"] = function(bufnr)
				for _ = 1, 5 do
					require("telescope.actions").move_selection_previous(bufnr)
				end
			end,
		},
	}
	return map
end

-- stylua: ignore start
local livegrep_cmd = {
	"rg", "--color=never", "--no-heading", "--with-filename",
	"--line-number", "--column", "--smart-case", "--trim", "--hidden",
}
local livegrep_hidden = function (pattern)
	return {"--glob", "!" .. pattern}
end
local find_files_cmd = {
	"fd", "--type", "file",
	"--hidden", "--color", "never",
}
local find_files_hidden = function (pattern)
	return {"-E", pattern}
end
-- stylua: ignore end
PluginVars.telescope_hide_pattern = { "**/.git/*" }

local borderchars = {
	rounded = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
	single = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
	none = { " ", " ", " ", " ", " ", " ", " ", " " },
}

M.config = function()
	for _, pattern in pairs(PluginVars.telescope_hide_pattern) do
		livegrep_cmd = vim.list_extend(livegrep_cmd, livegrep_hidden(pattern))
		find_files_cmd = vim.list_extend(find_files_cmd, find_files_hidden(pattern))
	end

	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			mappings = mappings(),
			borderchars = borderchars[Config.border_style],
			vimgrep_arguments = livegrep_cmd,
		},
		pickers = { find_files = { find_command = find_files_cmd } },
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	})

	local ok, _ = pcall(require("telescope").load_extension, "fzf")
	if not ok then
		vim.notify(
			"Failed to load `telescope-fzf-native.nvim`.\nPlease ensure it is built correctly.",
			vim.log.levels.ERROR
		)
	end
end
return M
