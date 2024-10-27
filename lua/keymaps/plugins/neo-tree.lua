local M = {}
M.keys = {
	{
		"<leader>e",
		"<Cmd>Neotree toggle<CR>",
		desc = "Neotree Toggle",
		mode = "n",
		noremap = true,
		silent = true,
	},
}
M.get_mappings = function()
	local mappings = {
		[vim.g.mapleader] = "none",
		["t"] = "none",
	}
	return mappings
end
return M
