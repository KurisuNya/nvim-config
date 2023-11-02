-- import nvim-indent_blankline safely
local ibl_status, ibl = pcall(require, "ibl")
if not ibl_status then
	return
end
local ibl_hooks_status, ibl_hooks = pcall(require, "ibl.hooks")
if not ibl_hooks_status then
	return
end

ibl_hooks.register(ibl_hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "IBLSelected", { fg = "#ff9e64" })
end)

ibl.setup({
	scope = {
		highlight = { "IBLSelected" },
		include = {
			node_type = {
				lua = { "return_statement", "table_constructor" },
			},
		},
	},
})

ibl_hooks.register(ibl_hooks.type.SCOPE_HIGHLIGHT, ibl_hooks.builtin.scope_highlight_from_extmark)
