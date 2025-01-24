---@class Integration
---@field map HighlightMap?
---@field link HighlightLink?
---@field exec function?

---@type Integration
local M = {}

M.map = {
  FzfLuaBackdrop = { nil, "background" },
  FzfLuaBorder = { "g_4" },
  FzfLuaPath = { "orange_blaze" },
  FzfLuaPathLineNr = { "blue" },
  FzfLuaHeaderBind = { "orange_smolder" },
  FzfLuaHeaderText = { "red_ember" },
  FzfLuaBufNr = { "blue" },
  FzfLuaTabTitle = { "orange_glow" },
  FzfLuaTabMarker = { "orange_glow" },
  FzfLuaPathColNr = { "blue" },
  FzfLuaBufFlagAlt = { "blue" },
  FzfLuaFzfPointer = { "orange_blaze" },
  FzfLuaMatch = { "orange_blaze" },
  FzfLuaLiveSym = { "blue" },
}

M.link = {
  FzfLuaTitle = "Title",
  FzfLuaCursor = "IncSearch",
  FzfLuaFzfCursorLine = "Visual",
}

return M
