local copilot = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "VeryLazy",
}

copilot.init = function()
	PluginVars.insert(PluginVars.lualine_hidden_lsp, "copilot")
end

copilot.opts = {
	suggestion = { enabled = false },
	panel = { enabled = false },
	filetypes = { markdown = true, yaml = true, help = true },
}

local sidekick = {
	"folke/sidekick.nvim",
	event = "VeryLazy",
}

sidekick.init = function()
	PluginVars.insert(PluginVars.projections_close_filetypes, "sidekick_terminal")
end

sidekick.opts = {
	nes = { enabled = false },
	cli = {
		mux = { backend = "tmux", enabled = true },
		win = {
			keys = {
				buffers = { "<c-b>", "buffers", mode = "nt", desc = "open buffer picker" },
				files = { "<c-f>", "files", mode = "nt", desc = "open file picker" },
				stopinsert = { "<esc>", "stopinsert", mode = "t", desc = "enter normal mode" },
				hide_n = false,
				hide_ctrl_q = false,
				hide_ctrl_dot = false,
				hide_ctrl_z = false,
				prompt = false,
				nav_left = false,
				nav_down = false,
				nav_up = false,
				nav_right = false,
			},
		},
		picker = "telescope",
	},
}

sidekick.keys = {
	{
		"<C-/>",
		function()
			require("sidekick.cli").toggle({ name = "copilot", focus = true })
		end,
		desc = "Sidekick Toggle Copilot",
		mode = { "n", "t", "i", "x" },
	},
	{
		"<leader>st",
		function()
			require("sidekick.cli").send({ msg = "{this}" })
		end,
		mode = { "x", "n" },
		desc = "Send This",
	},
	{
		"<leader>sf",
		function()
			require("sidekick.cli").send({ msg = "{file}" })
		end,
		desc = "Send File",
	},
	{
		"<leader>sv",
		function()
			require("sidekick.cli").send({ msg = "{selection}" })
		end,
		mode = { "x" },
		desc = "Send Visual Selection",
	},
	{
		"<leader>sp",
		function()
			require("sidekick.cli").prompt()
		end,
		mode = { "n", "x" },
		desc = "Sidekick Select Prompt",
	},
}

local M = { copilot, sidekick }
return Config.enable_copilot and M or {}
