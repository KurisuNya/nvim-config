local M = {}

---@param tbl table
---@return table
M.tbl_filter_same = function(tbl)
	local seen = {}
	local result = {}
	for _, v in ipairs(tbl) do
		if not seen[v] then
			seen[v] = true
			table.insert(result, v)
		end
	end
	return result
end

M.get_os = function()
	return (vim.uv or vim.loop).os_uname().sysname
end

M.is_windows = function()
	return M.get_os():find("Windows") ~= nil
end

M.is_linux = function()
	return M.get_os():find("Linux") ~= nil
end

---@param group string
---@param attr string
---@return string
M.get_hl_color = function(group, attr)
	return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end

---@param name string
---@return integer
M.create_augroup = function(name)
	return vim.api.nvim_create_augroup("KurisuNya_" .. name, { clear = true })
end

local lsp_attach_augroup = M.create_augroup("lsp_attach")

---@param filter fun(client: vim.lsp.Client, bufnr: integer): boolean
---@param fn fun(client: vim.lsp.Client, bufnr: integer)
M.lsp_on_attach = function(filter, fn)
	vim.api.nvim_create_autocmd("LspAttach", {
		group = lsp_attach_augroup,
		callback = function(args)
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if filter(client, bufnr) then
				fn(client, bufnr)
			end
		end,
	})
end

---@param client_name string
---@param fn fun(client: vim.lsp.Client, bufnr: integer)
M.lsp_on_attach_by_name = function(client_name, fn)
	M.lsp_on_attach(function(client, _)
		return client.name == client_name
	end, fn)
end

---@class Keymap
---@field mode string
---@field key string
---@field cmd string
---@field opts? table

---@param keymap Keymap
---@param bufnr integer
M.buffer_keymap_set = function(keymap, bufnr)
	local opts = keymap.opts or {}
	opts = vim.tbl_extend("keep", opts, { buffer = bufnr })
	vim.keymap.set(keymap.mode, keymap.key, keymap.cmd, opts)
end

---@param method string
---@param keymap Keymap
M.lsp_keymap_set_by_method = function(method, keymap)
	M.lsp_on_attach(function(client, _)
		return client.supports_method(method)
	end, function(_, bufnr)
		M.buffer_keymap_set(keymap, bufnr)
	end)
end

---@param client_name string
---@param keymap Keymap
M.lsp_keymap_set_by_name = function(client_name, keymap)
	M.lsp_on_attach(function(client, _)
		return client.name == client_name
	end, function(_, bufnr)
		M.buffer_keymap_set(keymap, bufnr)
	end)
end

---@param ... string
---@return boolean
M.plugin_exists = function(...)
	local plugins = require("lazy.core.config").spec.plugins
	for _, name in ipairs({ ... }) do
		if plugins[name] == nil then
			return false
		end
	end
	return true
end

---@param ... string
---@return boolean
M.plugin_loaded = function(...)
	local plugins = require("lazy.core.config").plugins
	for _, name in ipairs({ ... }) do
		if plugins[name] == nil or not plugins[name]._.loaded then
			return false
		end
	end
	return true
end

---@param plugin string
---@param fn function
M.on_plugin_loaded = function(plugin, fn)
	if M.plugin_loaded(plugin) then
		fn(plugin)
	else
		vim.api.nvim_create_autocmd("User", {
			group = Utils.create_augroup("on_" .. plugin .. "_load"),
			pattern = "LazyLoad",
			callback = function(event)
				if event.data == plugin then
					fn(plugin)
					return true
				end
			end,
		})
	end
end

function M.on_very_lazy(fn)
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			fn()
		end,
	})
end

function M.lazy_notify()
	local notifs = {}
	local function temp(...)
		table.insert(notifs, vim.F.pack_len(...))
	end

	local orig = vim.notify
	vim.notify = temp

	local timer = vim.uv.new_timer()
	local check = assert(vim.uv.new_check())

	local replay = function()
		timer:stop()
		check:stop()
		if vim.notify == temp then
			vim.notify = orig -- put back the original notify if needed
		end
		vim.schedule(function()
			---@diagnostic disable-next-line: no-unknown
			for _, notif in ipairs(notifs) do
				vim.notify(vim.F.unpack_len(notif))
			end
		end)
	end

	-- wait till vim.notify has been replaced
	check:start(function()
		if vim.notify ~= temp then
			replay()
		end
	end)
	-- or if it took more than 500ms, then something went wrong
	timer:start(500, 0, replay)
end

return M
