_G.Config = require("config")
_G.Icons = require("utils.icons")
_G.Utils = require("utils.utils")
_G.ErrorUtils = require("utils.error")
_G.Health = require("utils.health")

require("native.options")
require("native.keymaps")
require("native.autocmd")

-- Add health check command
vim.api.nvim_create_user_command("HealthCheck", function()
	Health.check_all()
end, { desc = "Run comprehensive health check" })

if Config.enable_plugins then
	require("plugins")
end
