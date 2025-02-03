---@class FzfIntegration: Integration
---@field fzf_colors table<string, string[]>

local M = {}

M.fzf_colors = {
  ["hl"] = { "fg", "AshenOrangeBlaze" },
  ["hl+"] = { "fg", "AshenOrangeSmolder" },
  ["fg"] = { "fg", "AshenG4" },
  ["bg"] = { "fg", "AshenBackground" },
  ["fg+"] = { "fg", "AshenG2" },
  ["bg+"] = { "bg", "Visual" },
  ["pointer"] = { "fg", "AshenOrangeGolden" },
  ["marker"] = { "fg", "AshenOrangeBlaze" },
  ["prompt"] = { "fg", "AshenOrangeBlaze" },
  ["info"] = { "fg", "AshenG4" },
  ["gutter"] = { "fg", "AshenBackground" },
  ["header"] = { "fg", "AshenRedEmber" },
  ["border"] = { "fg", "AshenG4" },
  ["spinner"] = { "fg", "AshenOrangeGlow" },
  ["query"] = { "fg", "AshenG2" },
  ["disabled"] = { "fg", "AshenG6" },
}

M.exec = function()
  vim.g.fzf_colors = M.fzf_colors
end

return M
