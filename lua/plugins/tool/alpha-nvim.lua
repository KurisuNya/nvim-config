local M = {}
M.config = function()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	-- header
	dashboard.section.header.val = {
		[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠀]],
		[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⣶⣖⣀⢲⣶⣶⢂⠢⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣶⣿⣿⠀]],
		[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⣶⣿⣿⡇⠀⢻⣿⣿⠁⢿⣿⡇⠿⢀⣿⣿⡆⣼⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣾⣿⣿⣿⡟⠀]],
		[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡐⣿⣿⣦⢰⣿⡿⠃⠋⣉⣅⣤⣤⣤⣤⣤⣤⣉⠉⠛⠴⣿⣿⢁⡾⢠⣿⣤⡀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⠁⠀]],
		[[⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣌⠻⠆⣿⠛⣉⡴⠚⠉⠉⠀⠀⠀⠹⣿⣿⣿⣿⠏⠀⠉⠛⢶⣤⠀⠶⣿⣿⣿⣿⣶⡀⢻⣿⣿⣿⣿⣿⣿⡿⠀⠀]],
		[[⠀⠀⠀⠀⠀⠀⣠⢧⠻⠿⣿⠟⢁⣴⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⣷⣄⠛⣿⣿⠋⣤⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀]],
		[[⠀⠀⠀⠀⠀⣾⣿⣿⣤⡽⢁⡶⢿⣿⣿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢾⣿⣿⣿⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⠋⠀⠀⠀]],
		[[⠀⠀⠀⠀⣾⣄⠀⣭⠏⣠⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣄⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢀⣶⣿⣿⣿⣿⠟⠁⡀⢻⠏⠀⠀⠀⠀]],
		[[⠀⠀⠀⣼⣶⣄⣒⡏⣰⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⢀⣶⣿⣿⣿⣿⠟⠁⣴⣿⣿⠀⠀⠀⠀⠀⠀]],
		[[⠀⠀⠀⣛⠛⠛⢿⢀⣯⣤⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⣠⣾⣿⣿⣿⣿⠟⠁⡄⢻⣿⣿⣿⣧⠀⠀⠀⠀⠀]],
		[[⠀⠀⢸⣭⣀⣛⡏⢸⣿⣿⣿⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠉⣤⣿⣿⣿⣿⣿⠛⠀⠀⣀⣽⢸⣿⣿⣿⣿⠀⠀⠀⠀⠀]],
		[[⠀⠀⢸⣿⡿⠿⡇⢿⣿⣿⡇⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⢁⣴⣿⣿⣿⣿⡿⠉⠀⠀⠀⣿⣿⣿⢨⣿⣿⣿⣿⠀⠀⠀⠀⠀]],
		[[⠀⠀⢰⣭⣴⣧⣧⢸⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⠟⠁⣤⣿⣿⣿⣿⣿⠛⠀⠀⠀⠀⠀⢠⣿⣿⣿⢸⣿⣿⣿⣿⠀⠀⠀⠀⠀]],
		[[⠀⠀⠀⣿⠛⢛⠛⠀⣷⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⠟⠉⣤⣾⣿⣿⣿⣿⠛⢉⠀⠀⠀⠀⠀⠀⠀⠀⠀⢉⠁⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀]],
		[[⠀⠀⠀⢠⠛⠛⣡⣷⠈⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⣤⣾⣿⣿⣿⣿⠛⢉⡤⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠋⣴⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀]],
		[[⠀⠀⠀⠀⢻⣿⣿⣿⣷⠈⣿⣿⣿⣦⠀⠀⢀⣤⣾⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⣠⠋⣴⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀]],
		[[⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣤⠙⠉⣠⣴⣿⣿⣿⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⠟⣠⣾⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀]],
		[[⠀⠀⠀⣾⠀⣤⠈⢿⣿⣿⣿⣿⣤⠙⠛⠋⠉⠀⠀⠀⠀⢀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⡿⠋⣠⣾⣿⣿⣿⣿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
		[[⠀⢀⣿⣀⣈⣤⣴⣤⠉⢿⣿⣿⣿⣿⣷⣤⣉⠓⠦⣤⣠⣿⣿⣿⣿⣿⠀⠀⣀⣤⠤⠒⢉⣤⣶⣿⣿⣿⣿⣿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
		[[⠀⠿⠛⠛⠉⠁⠀⠀⠀⠀⠈⠛⣿⣿⣿⣿⣿⣿⣿⣶⣦⣤⣤⣥⣅⣥⣤⣤⣤⣶⣾⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
		[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
		[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠛⠛⠛⠋⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	}
	dashboard.section.header.opts.hl = "Function"

	-- footer
	if vim.o.filetype == "lazy" then
		vim.cmd.close()
		vim.api.nvim_create_autocmd("User", {
			once = true,
			pattern = "AlphaReady",
			callback = function()
				require("lazy").show()
			end,
		})
	end
	dashboard.section.footer.opts.hl = "Comment"
	vim.api.nvim_create_autocmd("User", {
		once = true,
		pattern = "LazyVimStarted",
		callback = function()
			local stats = require("lazy").stats()
			local ms = math.floor(stats.startuptime)
			dashboard.section.footer.val = "KurisuNya Neovim ⏐ " .. stats.loaded .. " plugins in " .. ms .. "ms"
			pcall(vim.cmd.AlphaRedraw)
		end,
	})

	-- buttons
	local leader = "SPC"
	local function button(sc, txt, keybind, keybind_opts)
		local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")
		local opts = {
			position = "center",
			shortcut = sc,
			cursor = 3,
			width = 40,
			align_shortcut = "right",
			hl_shortcut = "Comment",
			hl = "Label",
		}
		if keybind then
			keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
			opts.keymap = { "n", sc_, keybind, keybind_opts }
		end
		local function on_press()
			local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
			vim.api.nvim_feedkeys(key, "t", false)
		end
		return {
			type = "button",
			val = txt,
			on_press = on_press,
			opts = opts,
		}
	end
	dashboard.button = button

	dashboard.section.buttons.val = {
		dashboard.button("p", "  Open Projects", "<Cmd>Telescope neovim-project history<CR>"),
		dashboard.button("f", "  Find Project", "<Cmd>Telescope neovim-project discover<CR>"),
		dashboard.button("s", "  Last Session", "<Cmd>NeovimProjectLoadRecent<cr>"),
		dashboard.button("h", "  File history", "<Cmd>Telescope oldfiles<CR>"),
		dashboard.button("c", "  File frecency", "<Cmd>Telescope frecency<CR>"),
	}

	-- layout
	dashboard.config.layout = {
		{ type = "padding", val = 3 },
		dashboard.section.header,
		{ type = "padding", val = 5 },
		dashboard.section.buttons,
		{ type = "padding", val = 1 },
		dashboard.section.footer,
	}

	-- setup
	alpha.setup(dashboard.config)
end
return M
