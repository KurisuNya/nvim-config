local nvim_jdtls_status, nvim_jdtls = pcall(require, "jdtls")
if not nvim_jdtls_status then
	return
end
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end
local lsp_inlayhints_status, lsp_inlayhints = pcall(require, "lsp-inlayhints")
if not lsp_inlayhints_status then
	return
end

local function plugin_exist(plugin)
	return require("lazy.core.config").spec.plugins[plugin] ~= nil
end
local function extend_or_override(config, custom, ...)
	if type(custom) == "function" then
		config = custom(config, ...) or config
	elseif custom then
		config = vim.tbl_deep_extend("force", config, custom) --[[@as table]]
	end
	return config
end

local on_attach = function(client, bufnr)
	lsp_inlayhints.on_attach(client, bufnr)
	require("core.keymaps.lspconfig").lsp_on_attach()
end
local capabilities = cmp_nvim_lsp.default_capabilities()

local opts = {
	root_dir = require("lspconfig.server_configurations.jdtls").default_config.root_dir,
	project_name = function(root_dir)
		return root_dir and vim.fs.basename(root_dir)
	end,
	jdtls_config_dir = function(project_name)
		return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
	end,
	jdtls_workspace_dir = function(project_name)
		return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
	end,
	cmd = { vim.fn.exepath("jdtls") },
	full_cmd = function(opts)
		local fname = vim.api.nvim_buf_get_name(0)
		local root_dir = opts.root_dir(fname)
		local project_name = opts.project_name(root_dir)
		local cmd = vim.deepcopy(opts.cmd)
		if project_name then
			vim.list_extend(cmd, {
				"-configuration",
				opts.jdtls_config_dir(project_name),
				"-data",
				opts.jdtls_workspace_dir(project_name),
			})
		end
		return cmd
	end,
	dap = { hotcodereplace = "auto", config_overrides = {} },
	test = true,
}

local mason_registry = require("mason-registry")
local bundles = {} ---@type string[]
if opts.dap and plugin_exist("nvim-dap") and mason_registry.is_installed("java-debug-adapter") then
	local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
	local java_dbg_path = java_dbg_pkg:get_install_path()
	local jar_patterns = {
		java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
	}
	if opts.test and mason_registry.is_installed("java-test") then
		local java_test_pkg = mason_registry.get_package("java-test")
		local java_test_path = java_test_pkg:get_install_path()
		vim.list_extend(jar_patterns, {
			java_test_path .. "/extension/server/*.jar",
		})
	end
	for _, jar_pattern in ipairs(jar_patterns) do
		for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
			table.insert(bundles, bundle)
		end
	end
end

local function attach_jdtls()
	local fname = vim.api.nvim_buf_get_name(0)
	local config = extend_or_override({
		cmd = opts.full_cmd(opts),
		root_dir = opts.root_dir(fname),
		init_options = {
			bundles = bundles,
		},
		capabilities = capabilities,
		on_attach = on_attach,
	}, opts.jdtls)
	nvim_jdtls.start_or_attach(config)
end
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = attach_jdtls,
})
