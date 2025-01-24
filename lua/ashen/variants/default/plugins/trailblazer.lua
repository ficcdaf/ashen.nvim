local M = {}
local c = require("ashen.colors")
local util = require("ashen.util")

---@param map HighlightMap
---@return table<string, HighlightNormalized>
local function add_inverted(map)
  local inverted = {}
  for name, spec in pairs(map) do
    local norm = util.normalize_hl(spec)
    local new_bg = norm.fg
    local new_fg = norm.bg
    if not new_fg then
      new_fg = c.g_1
    end
    if new_bg == c.g_1 then
      new_bg = c.g_8
    end
    norm.fg = new_bg
    norm.bg = new_fg
    inverted[name .. "Inverted"] = norm
  end
  -- dd(inverted)
  return vim.tbl_extend("error", map, inverted)
end

local function process_map(pre_map)
  local map_with_inverted = add_inverted(pre_map)
  local out = {}
  for k, v in pairs(map_with_inverted) do
    v.bold = true
    out[k] = v
  end
  return out
end

---@type HighlightMap
local pre_map = {
  TrailBlazerTrailMark = { c.orange_blaze },
  TrailBlazerTrailMarkNext = { c.orange_smolder },
  TrailBlazerTrailMarkPrevious = { c.blue },
  TrailBlazerTrailMarkCursor = { c.background, c.orange_glow },
  TrailBlazerTrailMarkNewest = { c.g_9, c.orange_blaze },
  TrailBlazerTrailMarkCustomOrd = { c.g_1, c.blue }, -- LightSlateBlue
  TrailBlazerTrailMarkGlobalChron = { c.g_1, c.blue }, -- Red
  TrailBlazerTrailMarkGlobalBufLineSorted = { c.g_1, c.red_kindling }, -- LightRed
  TrailBlazerTrailMarkGlobalFpathLineSorted = { c.g_1, c.red_kindling }, -- LightRed
  TrailBlazerTrailMarkGlobalChronBufLineSorted = { c.g_1, c.orange_golden }, -- Olive
  TrailBlazerTrailMarkGlobalChronFpathLineSorted = { c.g_1, c.orange_golden }, -- Olive
  TrailBlazerTrailMarkGlobalChronBufSwitchGroupChron = { c.g_1, c.red_burnt_crimson }, -- VioletRed
  TrailBlazerTrailMarkGlobalChronBufSwitchGroupLineSorted = { c.g_1, c.orange_smolder }, -- MediumSpringGreen
  TrailBlazerTrailMarkBufferLocalChron = { c.g_1, c.red_ember }, -- Green
  TrailBlazerTrailMarkBufferLocalLineSorted = { c.g_1, c.red_deep_ember }, -- LightGreen
}

M.map = process_map(pre_map)

-- M.autocmd = {
--   event = "BufEnter",
--   pattern = "*",
-- }

return M
