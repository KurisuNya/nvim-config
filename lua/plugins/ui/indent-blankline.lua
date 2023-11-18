local M = {}
M.config = function()
	local ibl_hooks = require("ibl.hooks")
	ibl_hooks.register(ibl_hooks.type.HIGHLIGHT_SETUP, function()
		vim.api.nvim_set_hl(0, "IBLSelected", { fg = "#ff9e64" })
	end)
	require("ibl").setup({
		scope = {
			highlight = { "IBLSelected" },
			include = {
				node_type = {
					all = { "return_statement", "table_constructor" },
				},
			},
		},
	})
	ibl_hooks.register(ibl_hooks.type.SCOPE_HIGHLIGHT, ibl_hooks.builtin.scope_highlight_from_extmark)
end
return M
