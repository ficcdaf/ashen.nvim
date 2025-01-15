local M = {}

-- highlight on yank needs to be set
-- differently using lazyvim so we
-- have to track whether the user is running it
M.lazyvim = false

---Settings configuration.
---@class Options table
M.opts = {
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

-- Merge user options with defaults
M.setup = function(opts)
  local setup = require("ashen.setup")
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
  setup.colors(M.opts)
  setup.theme(M.opts)
  if M.opts.terminal.enabled then
    setup.ansi(M.opts)
  end
end

-- Load the theme
M.load = function()
  M.lazyvim = pcall(require, "lazyvim")
  if vim.g.colors_name or M.opts.force_hi_clear then
    vim.cmd("hi clear")
  end
  vim.g.colors_name = "ashen"
  vim.o.termguicolors = true
  vim.api.nvim_command(string.format("set background=%s", "dark"))
  require("ashen.theme").load()
  require("ashen.plugins").load()
  require("ashen.autocmds").setup()
  require("ashen.languages").setup()
  if M.opts.terminal.enabled then
    require("ashen.ansi").load()
  end
end

return M
