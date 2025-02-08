local M = {}
M.config = function()
	local nvim_jdtls = require("jdtls")

	local get_root_dir = require("lspconfig.configs.jdtls").default_config.root_dir
	local function get_project_name(root_dir)
		return root_dir and vim.fs.basename(root_dir)
	end
	local function get_jdtls_config_dir(project_name)
		return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
	end
	local function get_jdtls_workspace_dir(project_name)
		return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
	end
	local cmd = { vim.fn.exepath("jdtls") }
	if KurisuNya.utils.plugin_exist("mason.nvim") then
		local mason_registry = require("mason-registry")
		local lombok_jar = mason_registry.get_package("jdtls"):get_install_path() .. "/lombok.jar"
		table.insert(cmd, string.format("--jvm-arg=-javaagent:%s", lombok_jar))
	end
	local function generate_cmd()
		local fname = vim.api.nvim_buf_get_name(0)
		local root_dir = get_root_dir(fname)
		local project_name = get_project_name(root_dir)
		local command = vim.deepcopy(cmd)
		if project_name then
			vim.list_extend(cmd, {
				"-configuration",
				get_jdtls_config_dir(project_name),
				"-data",
				get_jdtls_workspace_dir(project_name),
			})
		end
		return command
	end

	local mason_registry = require("mason-registry")
	local exist_dap = KurisuNya.utils.plugin_exist("nvim-dap")
	local function is_installed(name)
		return mason_registry.is_installed(name)
	end
	local function get_package(name)
		return mason_registry.get_package(name)
	end
	local function generate_dap_bundles()
		local bundles = {}
		if exist_dap and is_installed("java-debug-adapter") then
			local java_dbg_pkg = get_package("java-debug-adapter")
			local java_dbg_path = java_dbg_pkg:get_install_path()
			local jar_patterns = {
				java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
			}
			if is_installed("java-test") then
				local java_test_pkg = get_package("java-test")
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
			settings = { java = { signatureHelp = { enabled = true } } },
			init_options = { bundles = generate_dap_bundles() },
		}
		if KurisuNya.utils.plugin_exist("cmp-nvim-lsp") then
			opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
		end
		nvim_jdtls.start_or_attach(opts)

		local debug_filter = function(client, _)
			return client.name == "jdtls" and exist_dap and is_installed("java-debug-adapter")
		end
		KurisuNya.utils.lsp_on_attach(debug_filter, function(client, bufnr)
			nvim_jdtls.setup_dap({ hotcodereplace = "auto", config_overrides = {} })
			require("jdtls.dap").setup_dap_main_class_configs()
		end)

		local test_filter = function(client, _)
			return client.name == "jdtls" and mason_registry.is_installed("java-test")
		end
		KurisuNya.utils.lsp_on_attach(test_filter, function(_, bufnr)
			local keymaps = require("keymaps.plugins.nvim-jdtls").keymaps
			KurisuNya.utils.buffer_keymap_set(keymaps.pick_test, bufnr)
			KurisuNya.utils.buffer_keymap_set(keymaps.test_class, bufnr)
		end)
	end
	vim.api.nvim_create_autocmd("FileType", { pattern = "java", callback = attach_jdtls })
end
return M
