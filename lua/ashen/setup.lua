local M = {}

M.colors = function()
  local colors = require("ashen.colors")
  local opts = require("ashen.config").opts
  local override = opts.colors or {}
  for k, v in pairs(override) do
    colors[k] = v
  end
end

return M
