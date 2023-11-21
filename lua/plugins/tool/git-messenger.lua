local M = {}
M.config = function()
	vim.g.git_messenger_popup_content_margins = false
	vim.g.git_messenger_max_popup_height = 20
	vim.g.git_messenger_max_popup_width = 100
	vim.g.git_messenger_floating_win_opts = {
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	}
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = "gitmessengerpopup",
		callback = function(event)
			vim.opt_local.wrap = false
			require("core.keymaps.git-messenger").on_attach(event.buf)
		end,
	})
end
return M
