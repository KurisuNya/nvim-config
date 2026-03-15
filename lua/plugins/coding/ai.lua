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
	suggestion = {
		enabled = true,
		auto_trigger = true,
		keymap = { accept = "<C-CR>", accept_line = "<S-CR>" },
	},
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
				prompt = false,
				stopinsert = { "<c-q>", "stopinsert", mode = "t", desc = "enter normal mode" },
				hide_n = { "q", "hide", mode = "n", desc = "hide the terminal window" },
				hide_ctrl_q = false,
				hide_ctrl_dot = false,
				hide_ctrl_z = false,
				nav_left = { "<c-left>", "nav_left", expr = true, desc = "navigate to the left window" },
				nav_down = { "<c-down>", "nav_down", expr = true, desc = "navigate to the below window" },
				nav_up = { "<c-up>", "nav_up", expr = true, desc = "navigate to the above window" },
				nav_right = { "<c-right>", "nav_right", expr = true, desc = "navigate to the right window" },
			},
		},
		picker = "telescope",
	},
}

sidekick.keys = {
	{
		"<C-/>",
		function()
			require("sidekick.cli").toggle({ name = Config.ai_cli, focus = true })
		end,
		desc = "Sidekick Toggle CLI",
		mode = { "n", "t", "i", "x" },
	},
	{
		"<leader>st",
		function()
			require("sidekick.cli").send({ msg = "{this}" })
		end,
		mode = { "x", "n" },
		desc = "Sidekick Send This",
	},
	{
		"<leader>sf",
		function()
			require("sidekick.cli").send({ msg = "{file}" })
		end,
		desc = "Sidekick Send File",
	},
	{
		"<leader>sv",
		function()
			require("sidekick.cli").send({ msg = "{selection}" })
		end,
		mode = { "x" },
		desc = "Sidekick Send Visual Selection",
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
return Config.enable_ai and M or {}
