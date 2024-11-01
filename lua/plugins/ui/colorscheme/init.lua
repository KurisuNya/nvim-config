local colorscheme_plugin_map = {
	["tokyonight-night"] = "folke/tokyonight.nvim",
	["tokyonight-storm"] = "folke/tokyonight.nvim",
	["tokyonight-day"] = "folke/tokyonight.nvim",
	["tokyonight-moon"] = "folke/tokyonight.nvim",

	["catppuccin-latte"] = "catppuccin/nvim",
	["catppuccin-frappe"] = "catppuccin/nvim",
	["catppuccin-macchiato"] = "catppuccin/nvim",
	["catppuccin-mocha"] = "catppuccin/nvim",

	["material-darker"] = "marko-cerovac/material.nvim",
	["material-lighter"] = "marko-cerovac/material.nvim",
	["material-oceanic"] = "marko-cerovac/material.nvim",
	["material-palenight"] = "marko-cerovac/material.nvim",
	["material-deep-ocean"] = "marko-cerovac/material.nvim",

	["ayu-dark"] = "Shatur/neovim-ayu",
	["ayu-light"] = "Shatur/neovim-ayu",
	["ayu-mirage"] = "Shatur/neovim-ayu",
}

local simple_config = function(name)
	vim.cmd.colorscheme(name)
end
local plugin_config_map = {
	["folke/tokyonight.nvim"] = function(name)
		require("plugins.ui.colorscheme.tokyonight").config(name)
	end,
	["catppuccin/nvim"] = simple_config,
	["marko-cerovac/material.nvim"] = function(name)
		require("plugins.ui.colorscheme.material").config(name)
	end,
	["Shatur/neovim-ayu"] = simple_config,
}

local switch_to_colorscheme = function(name)
	local plugin_name = colorscheme_plugin_map[name]
	if not plugin_name then
		vim.notify("Colorscheme " .. name .. " not found", vim.log.levels.ERROR)
		return
	end
	plugin_config_map[plugin_name](name)
	vim.notify("Switched to colorscheme " .. name, vim.log.levels.INFO)
end
vim.api.nvim_create_user_command("ColorschemeSwitch", function(opts)
	local params = vim.split(opts.args, "%s+", { trimempty = true })
	switch_to_colorscheme(params[1])
end, {
	nargs = 1,
	complete = function(_, cmd_line)
		local params = vim.split(cmd_line, "%s+", { trimempty = true })
		if #params == 1 then
			return vim.tbl_keys(colorscheme_plugin_map)
		end
	end,
})

local keys = require("keymaps.plugins.colorscheme").keys
for _, key in ipairs(keys) do
	vim.api.nvim_set_keymap(key.mode, key[1], key[2], {
		noremap = key.noremap,
		silent = key.silent,
		desc = key.desc,
	})
end

local M = {
	{ "folke/tokyonight.nvim" },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "marko-cerovac/material.nvim" },
	{ "Shatur/neovim-ayu" },
}
local colorscheme = KurisuNya.config.colorscheme
local plugin_name = colorscheme_plugin_map[colorscheme]
if plugin_name then
	for _, plugin in ipairs(M) do
		if plugin[1] == plugin_name then
			plugin.config = function()
				plugin_config_map[plugin_name](colorscheme)
			end
			plugin.lazy = false
			plugin.priority = 1000
			break
		end
	end
end
return M
