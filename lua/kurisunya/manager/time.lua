local ffi = require("ffi")

local M = {}

M._start = vim.uv.hrtime()

M.C = nil

function M.elapsed_ms()
  if M.C == nil then
    pcall(function()
      ffi.cdef([[
        typedef long time_t;
        typedef int clockid_t;
        typedef struct timespec {
          time_t   tv_sec;        /* seconds */
          long     tv_nsec;       /* nanoseconds */
        } nanotime;
        int clock_gettime(clockid_t clk_id, struct timespec *tp);
      ]])
      M.C = ffi.C
    end)
  end

  local function real()
    local pnano = assert(ffi.new("nanotime[?]", 1))
    local CLOCK_PROCESS_CPUTIME_ID = jit.os == "OSX" and 12 or 2
    ffi.C.clock_gettime(CLOCK_PROCESS_CPUTIME_ID, pnano)
    return tonumber(pnano[0].tv_sec) * 1e3 + tonumber(pnano[0].tv_nsec) / 1e6
  end

  local function fallback() return (vim.uv.hrtime() - M._start) / 1e6 end

  local ok, ret = pcall(real)
  if ok then
    M.elapsed_ms = real
    return ret
  else
    M.elapsed_ms = fallback
    return fallback()
  end
end

return M
