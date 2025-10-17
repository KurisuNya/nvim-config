PluginVars.insert(PluginVars.treesitter_ensure_installed, "c")
PluginVars.insert(PluginVars.treesitter_ensure_installed, "cpp")

PluginVars.insert(PluginVars.mason_ensure_installed, "clangd")
PluginVars.insert(PluginVars.mason_ensure_installed, "clang-format")
PluginVars.insert(PluginVars.mason_ensure_installed, "codelldb")
PluginVars.insert(PluginVars.mason_ensure_installed, "cpptools")

PluginVars.insert(PluginVars.conform_formatters, { name = "clang_format", filetypes = { "c", "cpp" } })
PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("clangd")
	vim.lsp.config("clangd", {
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--header-insertion=iwyu",
			"--completion-style=detailed",
			"--function-arg-placeholders",
			"--fallback-style=llvm",
		},
		root_markers = {
			"Makefile",
			"configure.ac",
			"configure.in",
			"config.h.in",
			"meson.build",
			"meson_options.txt",
			"build.ninja",
			".clangd",
			".clang-tidy",
			".clang-format",
			"compile_commands.json",
			"compile_flags.txt",
			"configure.ac",
			".git",
		},
		init_options = {
			usePlaceholders = true,
			completeUnimported = true,
			clangdFileStatus = true,
		},
	})
end)

PluginVars.dap_adapters["codelldb"] = {
	type = "server",
	port = "${port}",
	executable = {
		command = "codelldb",
		args = { "--port", "${port}" },
	},
}
PluginVars.dap_adapters["cppdbg"] = {
	id = "cppdbg",
	type = "executable",
	command = "OpenDebugAD7",
}

local dap_config = function()
	return {
		{
			type = "codelldb",
			request = "launch",
			name = "Launch file",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
		},
		{
			type = "codelldb",
			request = "attach",
			name = "Attach to process",
			pid = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			name = "Attach to gdbserver",
			type = "cppdbg",
			request = "launch",
			MIMode = "gdb",
			miDebuggerServerAddress = "localhost:3333",
			cwd = "${workspaceFolder}",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
		},
	}
end
PluginVars.dap_configurations["c"] = dap_config
PluginVars.dap_configurations["cpp"] = dap_config

return {}
