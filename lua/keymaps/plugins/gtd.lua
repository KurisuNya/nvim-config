local M = {}
local opts = { noremap = true, silent = true }
local function extend_desc(desc)
	return vim.tbl_extend("force", { desc = desc }, opts)
end
M.keymaps = {
	goto_definition = {
		key = "gd",
		cmd = function()
			require("gtd").exec({ command = "edit" })
		end,
		mode = "n",
		opts = extend_desc("Lsp Goto Definition"),
	},
}
return M
