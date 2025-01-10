local M = {}

M.colors = function(opts)
  local colors = require("ashen.colors")
  local new = opts.colors or {}
  for k, v in pairs(new) do
    colors[k] = v
  end
end

---override HL groups
---@param opts Options
M.theme = function(opts)
  local util = require("ashen.util")
  local theme = require("ashen.theme")
  -- TODO: Let users provide palette color names instead of Hex codes
  -- and check for it automatically
  if opts.transparent then
    for _, name in ipairs(theme.transparent_bg) do
      theme.map[name] = util.remove_bg(theme.map[name])
    end
  end
  for k, v in pairs(opts.hl.merge_override or {}) do
    if theme.map[k] == nil then
      theme.map[k] = v
    else
      theme.map[k] = vim.tbl_deep_extend("force", theme.map[k], v)
    end
  end
  for k, v in pairs(opts.hl.force_override or {}) do
    theme.map[k] = v
  end
end

---@param opts Options
M.ansi = function(opts)
  local ansi = require("ashen.ansi")
  ansi.colors = ansi.generate_colors(opts)
end

return M
