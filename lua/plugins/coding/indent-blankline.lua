M = {
	"lukas-reineke/indent-blankline.nvim",
	event = "VeryLazy",
}

M.config = function()
	local ibl_hooks = require("ibl.hooks")
	require("ibl").setup({
		scope = { include = { node_type = {
			all = { "return_statement", "table_constructor" },
		} } },
	})
	ibl_hooks.register(ibl_hooks.type.SCOPE_HIGHLIGHT, ibl_hooks.builtin.scope_highlight_from_extmark)
end

return M
