local M = {}

M.get_hl_color = function(group, attr)
	return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end

local lsp_group = vim.api.nvim_create_augroup("KurisuNyaLsp", {})
M.lsp_on_attach = function(filter, fn)
	vim.api.nvim_create_autocmd("LspAttach", {
		group = lsp_group,
		callback = function(args)
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if filter(client, bufnr) then
				fn(client, bufnr)
			end
		end,
	})
end

M.buffer_keymap_set = function(keymap, bufnr)
	local opts = keymap.opts or {}
	opts = vim.tbl_extend("keep", opts, { buffer = bufnr })
	vim.keymap.set(keymap.mode, keymap.key, keymap.cmd, opts)
end

M.lsp_keymap_set_by_method = function(method, keymap)
	M.lsp_on_attach(function(client, _)
		return client.supports_method(method)
	end, function(_, bufnr)
		M.buffer_keymap_set(keymap, bufnr)
	end)
end

M.lsp_keymap_set_by_client = function(client_name, keymap)
	M.lsp_on_attach(function(client, _)
		return client.name == client_name
	end, function(_, bufnr)
		M.buffer_keymap_set(keymap, bufnr)
	end)
end

if not KurisuNya.config.enable_plugin then
	KurisuNya.utils = M
	return
end

M.plugin_exist = function(name)
	local exists = require("lazy.core.config").spec.plugins[name] ~= nil
	if not exists then
		vim.notify("Plugin " .. name .. " does not exist", "error")
	end
	return exists
end

M.plugins_exist = function(names)
	for _, plugin in ipairs(names) do
		if not M.plugin_exist(plugin) then
			return false
		end
	end
	return true
end

function M.plugin_loaded(name)
	local Config = require("lazy.core.config")
	return Config.plugins[name] and Config.plugins[name]._.loaded
end

function M.plugins_loaded(names)
	for _, plugin in ipairs(names) do
		if not M.plugin_loaded(plugin) then
			return false
		end
	end
	return true
end

function M.on_plugin_loaded(name, fn)
	if M.plugin_loaded(name) then
		fn(name)
	else
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyLoad",
			callback = function(event)
				if event.data == name then
					fn(name)
					return true
				end
			end,
		})
	end
end
KurisuNya.utils = M
