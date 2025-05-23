local M = {}
M.config = function()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	-- header
	dashboard.section.header.val = KurisuNya.config.header
	dashboard.section.header.opts.hl = "Function"

	-- footer
	if vim.o.filetype == "lazy" then
		vim.cmd.close()
		vim.api.nvim_create_autocmd("User", {
			group = KurisuNya.utils.create_augroup("show_lazy"),
			once = true,
			pattern = "AlphaReady",
			callback = function()
				require("lazy").show()
			end,
		})
	end
	dashboard.section.footer.opts.hl = "Comment"
	vim.api.nvim_create_autocmd("User", {
		group = KurisuNya.utils.create_augroup("show_footer"),
		once = true,
		pattern = "LazyVimStarted",
		callback = function()
			local stats = require("lazy").stats()
			local ms = math.floor(stats.startuptime)
			local plugin_info = " ⏐ " .. stats.loaded .. " plugins in " .. ms .. "ms"
			dashboard.section.footer.val = "KurisuNya Neovim" .. plugin_info
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
		dashboard.button("p", "  Open Project", "<Cmd>Telescope projections<CR>"),
		dashboard.button("s", "  Last Session", "<Cmd>ProjectionsLastSession<CR>"),
		dashboard.button("h", "  File History", "<Cmd>Telescope oldfiles<CR>"),
		dashboard.button("l", "󰒲  Lazy Manager", "<Cmd> Lazy <CR>"),
		dashboard.button("m", "  Mason Manager", "<Cmd> Mason <CR>"),
	}

	-- layout
	dashboard.config.layout = {
		{ type = "padding", val = 2 },
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
