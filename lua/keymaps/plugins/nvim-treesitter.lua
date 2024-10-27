local M = {}
M.incremental_selection = {
	keymaps = {
		init_selection = "<C-l>",
		node_incremental = "<C-l>",
		scope_incremental = false,
		node_decremental = "<C-h>",
	},
}
M.textobjects = {
	goto_next_start = { ["]f"] = "@function.outer", ["<C-j>"] = "@parameter.inner" },
	goto_next_end = { ["]F"] = "@function.outer" },
	goto_previous_start = { ["[f"] = "@function.outer", ["<C-k>"] = "@parameter.inner" },
	goto_previous_end = { ["[F"] = "@function.outer" },
}
return M
