local M = {}

---Settings configuration.
---@class Options table
M.opts = {
  -- toggle text style options
  ---@type table<string, boolean>
  style = {},
  -- toggle group specific settings
  style_presets = {
    bold_functions = false,
    italic_comments = false,
  },
  -- override palette
  ---@type Palette
  colors = {},
  -- override highlights
  hl = {
    ---Overwrite; omitted fields are cleared
    ---@type HighlightMap
    force_override = {},
    ---Merge fields with defaults
    ---@type HighlightMap
    merge_override = {},
    ---Link Highlight1 -> Highlight2
    ---Overrides all default links
    ---@type table<HighlightName, HighlightName>
    link = {},
  },
  -- use transparent background
  transparent = false,
  -- force clear other highlights
  force_hi_clear = false,
  -- set terminal to Ashen ANSI palette
  -- respects colors set above
  -- allows override specific ANSI colors
  terminal = {
    enabled = true,
    ---@type AnsiMap
    colors = {},
  },
  -- configure plugin integrations
  plugins = {
    -- automatically load plugin integrations
    autoload = true,
    ---if autoload: plugins to SKIP
    ---if not autoload: plugins to LOAD
    ---@type string[]
    override = {},
  },
}

return M
