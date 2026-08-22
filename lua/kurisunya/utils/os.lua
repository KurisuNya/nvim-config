local M = {}

local sysname = vim.uv.os_uname().sysname

---@return string sysname System name
M.get_sysname = function() return sysname end

---@return boolean is_windows True if the system is Windows
M.is_windows = function() return M.get_sysname():find("Windows") ~= nil end

---@return boolean is_linux True if the system is Linux
M.is_linux = function() return M.get_sysname():find("Linux") ~= nil end

---@return boolean is_mac True if the system is macOS
M.is_mac = function() return M.get_sysname():find("Darwin") ~= nil end

M.linux = {
  ---@return boolean is_in_tty True if the terminal is a Linux console (tty)
  is_in_tty = function() return vim.env.TERM == "linux" end,
}

return M
