local M = {}

local palette = {
  "background",
  "red_ember",
  "orange_glow",
  "orange_smolder",
  "blue",
  "g_4",
  "g_3",
  "g_2",
  "g_5",
  "red_ember",
  "orange_glow",
  "orange_smolder",
  "blue",
  "g_4",
  "g_3",
  "g_2",
}
-- local reference_palette = {
--   "#121212",
--   "#B14242",
--   "#D87C4A",
--   "#E49A44",
--   "#4A8B8B",
--   "#a7a7a7",
--   "#b4b4b4",
--   "#d5d5d5",
--   "#949494",
--   "#B14242",
--   "#D87C4A",
--   "#E49A44",
--   "#4A8B8B",
--   "#a7a7a7",
--   "#b4b4b4",
--   "#d5d5d5",
-- }

---@alias AnsiMap table<integer, HexCode> -- where integer ∈ [0, 15]

M.colors = nil

---@return string[]
local generate_colors = function()
  local opts = require("ashen.config").opts
  local colors = {}
  local override = {}
  if opts ~= nil and opts.terminal ~= nil then
    override = opts.terminal.colors or {}
  end
  local c = require("ashen.colors")
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
  local opts = require("ashen.config").opts
  if opts.terminal.enabled then
    M.colors = generate_colors()
    for i, color in ipairs(M.colors) do
      vim.g["terminal_color_" .. i - 1] = color
    end
  end
end

return M
