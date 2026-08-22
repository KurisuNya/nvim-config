---@class Ui.ViewData
---@field lines string[]
---@field hls {[1]: integer, [2]: integer, [3]: integer, [4]: string}[]
---@field line_to_name table<integer, string>
---@field name_to_line table<string, integer>
---@field name_cols table<integer, integer> -- 行 → 插件名起始字节列

local M = {}

local ns = vim.api.nvim_create_namespace("pack_float_ui")

local PLUGIN_INDENT = "   "
local DETAIL_INDENT = "     "

local function short_rev(rev) return rev and rev:sub(1, 8) or "unknown" end

---@param vm Ui.ViewModel
---@return Ui.ViewData
M.static_view = function(vm)
  local lines, hls = {}, {}
  local line_to_name, name_to_line, name_cols = {}, {}, {}

  local function add(text, hl)
    local row = #lines
    lines[#lines + 1] = text
    if hl then
      hls[#hls + 1] = { row, 0, #text, hl }
    end
    return row
  end

  local function add_hl(row, start_col, end_col, hl) hls[#hls + 1] = { row, start_col, end_col, hl } end

  local function mark_plugin(row, name, name_col)
    line_to_name[row + 1] = name
    name_to_line[name] = name_to_line[name] or row + 1
    if name_col then
      name_cols[row + 1] = name_col
    end
  end

  add("")

  local help =
    " [R] Refresh  [u] Update  [U] Update all  [x] Uninstall  [X] Clean  [Enter] Details  [Esc] Close"
  local help_row = add(help)
  for start_pos, end_pos in help:gmatch("()%b[]()") do
    add_hl(help_row, start_pos - 1, end_pos - 1, "@punctuation.special")
  end

  add("")

  local function format_version(version, version_str)
    if version == nil then
      return "default branch"
    end
    return tostring(version_str or version)
  end

  local function add_plugin(entry, pending, kind)
    local plugin = entry.plugin
    local name = plugin.name
    local commits = entry.commits
    local progress = entry.progress
    local icon = kind == "not_managed" and "○" or (entry.plugin.active and "●" or "○")
    local line = PLUGIN_INDENT .. icon .. " " .. name .. (progress and ("  " .. progress) or "")
    local revision = pending
        and ("%s → %s"):format(short_rev(plugin.rev), short_rev(plugin.rev_to))
      or short_rev(plugin.rev)

    local row = add(line)

    local icon_start = #PLUGIN_INDENT
    mark_plugin(row, name, icon_start + #icon + 1)
    add_hl(row, icon_start, icon_start + #icon, "@punctuation.special")
    local name_start = icon_start + #icon + 1
    add_hl(row, name_start, name_start + #name, pending and "NormalFloat" or "NormalFloat")
    if progress then
      local progress_start = name_start + #name + 2
      add_hl(
        row,
        progress_start,
        #line,
        progress == "updated" and "DiagnosticOk"
          or progress == "failed" and "DiagnosticError"
          or "DiagnosticInfo"
      )
    end

    if entry.expanded then
      -- 详情行 = 标签列(Comment 色) + 值列(各自语义色)
      local label_width = 9 -- "path      " 定宽 (path/src/version/revision 语义对齐)
      local function detail_row(label, value, value_hl)
        value = value or ""
        local prefix = DETAIL_INDENT .. string.format("%-" .. label_width .. "s", label)
        local row = add(prefix .. value, "Conceal")
        mark_plugin(row, name)
        local value_start = #prefix
        add_hl(row, value_start, value_start + #value, value_hl)
      end
      detail_row("path", plugin.path, "@markup.link")
      detail_row("src", plugin.src, "@markup.link")
      detail_row("version", format_version(plugin.version, plugin.version_str), "@string")
      detail_row("revision", revision, "@variable.builtin")
      if not pending then
        add("", "Comment")
        mark_plugin(#lines - 1, name)
      end
    end

    if pending then
      if entry.expanded then
        add("", "Comment")
        mark_plugin(#lines - 1, name)
      end

      if commits == nil then
        add(DETAIL_INDENT .. "commits: loading...", "Comment")
        mark_plugin(#lines - 1, name)
      elseif #commits == 0 then
        add(DETAIL_INDENT .. "commits: no new commits found", "Comment")
        mark_plugin(#lines - 1, name)
      else
        for _, commit in ipairs(commits) do
          local hash = commit.hash
          local message = commit.message
          local commit_line = message ~= "" and (DETAIL_INDENT .. "%s  %s"):format(hash, message)
            or (DETAIL_INDENT .. hash)
          local commit_row = add(commit_line)
          mark_plugin(commit_row, name)
          if hash:match("^%x+$") then
            add_hl(commit_row, #DETAIL_INDENT, #DETAIL_INDENT + #hash, "Number")
          end
          local prefix_len = commit.conventional_prefix
          local message_start = #DETAIL_INDENT + #hash + 2
          if prefix_len then
            add_hl(commit_row, message_start, message_start + #prefix_len, "@punctuation.special")
          end
          local time_range = commit.time_range
          if time_range then
            local range_start, range_end = message:find("%([^()]+%)$")
            if range_start then
              add_hl(
                commit_row,
                message_start + range_start - 1,
                message_start + range_end,
                "Comment"
              )
            end
          end
        end
      end

      add("", "Comment")
      mark_plugin(#lines - 1, name)
    end
  end

  local function render_section(section)
    local pending = section.kind == "pending"
    add((" %s (%d)"):format(section.title, #section.entries), "Bold")
    if #section.entries == 0 then
      if pending then
        add(section.checking and "   checking..." or "   no pending updates", "Comment")
      else
        add("  no " .. string.lower(section.title) .. " plugins", "Comment")
      end
    else
      for _, entry in ipairs(section.entries) do
        add_plugin(entry, pending, section.kind)
      end
    end
  end

  -- status 行(与原 build_content 的 status 显示对齐)
  if vm.status ~= "" then
    add("", "Comment")
  end

  render_section(vm.sections[1], vm)
  add("")
  render_section(vm.sections[2], vm)
  add("")
  render_section(vm.sections[3], vm)

  return {
    lines = lines,
    hls = hls,
    line_to_name = line_to_name,
    name_to_line = name_to_line,
    name_cols = name_cols,
  }
end

---@param bufnr integer
---@param data Ui.ViewData
M.apply = function(bufnr, data)
  vim.bo[bufnr].modifiable = true
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, data.lines)
  vim.bo[bufnr].modifiable = false
  vim.bo[bufnr].modified = false

  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  for _, hl in ipairs(data.hls) do
    vim.api.nvim_buf_set_extmark(bufnr, ns, hl[1], hl[2], {
      end_col = hl[3],
      hl_group = hl[4],
    })
  end
end

---@param data Ui.ViewData
---@param row integer
---@return string?
M.plugin_at = function(data, row) return data.line_to_name[row] end

return M
