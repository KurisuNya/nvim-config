PluginVars.mason_ensure_installed = {}

return {
	"williamboman/mason.nvim",
	opts = { ui = { border = Config.border_style } },
	config = function(_, opts)
		require("mason").setup(opts)
		local tbl = Utils.tbl_filter_same(PluginVars.mason_ensure_installed)
		local mr = require("mason-registry")
		mr.refresh(function()
			for _, tool in ipairs(tbl) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end)
	end,
	event = "VeryLazy",
}
