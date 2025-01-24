local M = {}

---@alias AnsiMap table<integer, HexCode> -- where integer ∈ [0, 15]

M.colors = nil

---@return string[]
local generate_colors = function()
  local opts = require("ashen.state").opts
  local colors = {}
  local override = {}
  if opts ~= nil and opts.terminal ~= nil then
    override = opts.terminal.colors or {}
  end
  local c = require("ashen.colors")
  local variant = require("ashen.state").variant
  local palette = require("ashen.variants." .. variant .. ".ansi")
  for i, name in ipairs(palette) do
    local new = ""
    if override[i - 1] ~= nil then
      new = override[i - 1]
    else
      new = c[name]
    end
    colors[i] = new
  end
  return colors
end

M.load = function()
  local opts = require("ashen.state").opts
  if opts.terminal.enabled then
    M.colors = generate_colors()
    for i, color in ipairs(M.colors) do
      vim.g["terminal_color_" .. i - 1] = color
    end
  end
end

return M
