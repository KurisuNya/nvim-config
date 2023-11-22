local M = {}
M.config = function()
	local ibl_hooks = require("ibl.hooks")
	local function get_color(group, attr)
		return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
	end
	ibl_hooks.register(ibl_hooks.type.HIGHLIGHT_SETUP, function()
		vim.api.nvim_set_hl(0, "IBLSelected", { fg = get_color("IncSearch", "bg#") })
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
