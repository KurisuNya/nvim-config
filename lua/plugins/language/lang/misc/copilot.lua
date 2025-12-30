if not Config.enable_copilot then
	return {}
end

local function accept_line(item)
	local insert_text = item.insert_text
	if type(insert_text) == "string" then
		local range = item.range
		if range then
			local lines = vim.split(insert_text, "\n")
			local current_lines = vim.api.nvim_buf_get_text(
				range.start.buf,
				range.start.row,
				range.start.col,
				range.end_.row,
				range.end_.col,
				{}
			)

			local row = 1
			while row <= #lines and row <= #current_lines and lines[row] == current_lines[row] do
				row = row + 1
			end

			local line_text = row <= #lines and lines[row] or ""
			item.insert_text = table.concat(vim.list_slice(lines, 1, row - 1), "\n")
				.. (row <= #current_lines and "" or "\n")
				.. line_text
		end
	end
	return item
end

PluginVars.insert(PluginVars.mason_ensure_installed, "copilot-language-server")
PluginVars.insert(PluginVars.lualine_hidden_lsp, "copilot")
PluginVars.insert(PluginVars.lsp_config, function()
	local CREATE_UNDO = vim.api.nvim_replace_termcodes("<c-G>u", true, true, true)
	local create_undo = function()
		if vim.api.nvim_get_mode().mode == "i" then
			vim.api.nvim_feedkeys(CREATE_UNDO, "n", false)
		end
	end

	vim.lsp.enable("copilot")
	vim.schedule(function()
		vim.lsp.inline_completion.enable()
	end)

	vim.keymap.set("i", "<C-k>", function()
		create_undo()
		vim.lsp.inline_completion.get()
	end, { noremap = false, silent = true, desc = "Accept Copilot suggestion (all)" })

	vim.keymap.set("i", "<C-j>", function()
		create_undo()
		vim.lsp.inline_completion.get({ on_accept = accept_line })
	end, { noremap = false, silent = true, desc = "Accept Copilot suggestion (line)" })
end)

return {}
