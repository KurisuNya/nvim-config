local M = {}
M.config = function()
	local nvim_jdtls = require("jdtls")
	local mason_registry = require("mason-registry")

	local function plugin_exist(plugin)
		return require("lazy.core.config").spec.plugins[plugin] ~= nil
	end
	local get_root_dir = require("lspconfig.server_configurations.jdtls").default_config.root_dir
	local function get_project_name(root_dir)
		return root_dir and vim.fs.basename(root_dir)
	end
	local function get_jdtls_config_dir(project_name)
		return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
	end
	local function get_jdtls_workspace_dir(project_name)
		return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
	end

	local function generate_cmd()
		local fname = vim.api.nvim_buf_get_name(0)
		local root_dir = get_root_dir(fname)
		local project_name = get_project_name(root_dir)
		local cmd = { vim.fn.exepath("jdtls") }
		if project_name then
			vim.list_extend(cmd, {
				"-configuration",
				get_jdtls_config_dir(project_name),
				"-data",
				get_jdtls_workspace_dir(project_name),
			})
		end
		return cmd
	end
	local function generate_dap_bundles()
		local bundles = {} ---@type string[]
		if plugin_exist("nvim-dap") and mason_registry.is_installed("java-debug-adapter") then
			local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
			local java_dbg_path = java_dbg_pkg:get_install_path()
			local jar_patterns = {
				java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
			}
			if mason_registry.is_installed("java-test") then
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

		return bundles
	end

	local function attach_jdtls()
		local opts = {
			cmd = generate_cmd(),
			root_dir = get_root_dir(vim.api.nvim_buf_get_name(0)),
			settings = {
				java = {
					signatureHelp = { enabled = true },
				},
			},
			init_options = { bundles = generate_dap_bundles() },
			on_attach = function(client, bufnr)
				require("lsp-inlayhints").on_attach(client, bufnr)
				require("core.keymaps.lspconfig").lsp_on_attach()
				if plugin_exist("nvim-dap") and mason_registry.is_installed("java-debug-adapter") then
					nvim_jdtls.setup_dap({ hotcodereplace = "auto", config_overrides = {} })
					require("jdtls.dap").setup_dap_main_class_configs()
				end
				if mason_registry.is_installed("java-test") then
					require("core.keymaps.lspconfig").jdtls_debug_on_attach()()
				end
			end,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		}
		nvim_jdtls.start_or_attach(opts)
	end
	vim.api.nvim_create_autocmd("FileType", { pattern = "java", callback = attach_jdtls })
end
return M
