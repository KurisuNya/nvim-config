local M = {}
local opts = { noremap = true, silent = true }
local function extend_desc(desc)
	return vim.tbl_extend("force", { desc = desc }, opts)
end
M.keymaps = {
	test_class = {
		key = "<leader>dj",
		cmd = require("jdtls.dap").test_class,
		mode = "n",
		opts = extend_desc("Dap Java Test Class"),
	},
	pick_test = {
		key = "<leader>dJ",
		cmd = require("jdtls.dap").pick_test,
		mode = "n",
		opts = extend_desc("Dap Java Pick Test"),
	},
}
return M
