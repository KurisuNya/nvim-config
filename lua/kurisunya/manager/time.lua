local ffi = require("ffi")
ffi.cdef([[
  typedef struct timespec {
    int64_t tv_sec;
    long tv_nsec;
  } nanotime;
  int clock_gettime(int clk_id, struct timespec *tp);
]])
local CLOCK_PROCESS_CPUTIME_ID = Utils.os.is_mac() and 12 or 2

local function process_cputime()
  local pnano = ffi.new("nanotime[1]")
  ffi.C.clock_gettime(CLOCK_PROCESS_CPUTIME_ID, pnano)
  return tonumber(pnano[0].tv_sec) * 1e3 + tonumber(pnano[0].tv_nsec) / 1e6
end

local M = {}

local use_cputime = true
local hrtime_start = vim.uv.hrtime()

M.elapsed_ms = function()
  if use_cputime then
    local ok, ret = pcall(process_cputime)
    if ok then
      return ret
    end
    use_cputime = false -- fallback to hrtime if process_cputime fails
  end
  return (vim.uv.hrtime() - hrtime_start) / 1e6
end

return M
