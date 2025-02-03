local M = {}

-- highlight on yank needs to be set
-- differently using lazyvim so we
-- have to track whether the user is running it
M.lazyvim = false

-- Merge user options with defaults
M.setup = function(opts)
  local state = require("ashen.state")
  state.opts = vim.tbl_deep_extend("force", state.opts, opts or {})
  state.variant = state.opts.variant
end

---Overrides the palette according to user opts
local palette_override = function()
  local opts = require("ashen.state").opts
  if opts.colors == {} or not opts.colors then
    return
  end
  local palette = require("ashen.colors")
  local override = opts.colors or {}
  for k, v in pairs(override) do
    palette[k] = v
  end
end

-- Load the theme
M.load = function()
  local state = require("ashen.state")
  local opts = state.opts
  -- this is kinda cringe since it requires
  -- lazyvim to be loaded before ashen, but
  -- I can't think of a better way to do this :/
  M.lazyvim = pcall(require, "lazyvim")

  if vim.g.colors_name or opts.force_hi_clear then
    vim.cmd("hi clear")
  end
  vim.g.colors_name = "ashen"
  vim.o.termguicolors = true
  palette_override()
  local theme = require("ashen.theme")
  theme.load()
  require("ashen.plugins").load()
  require("ashen.autocmds").load()
  require("ashen.languages").load()
  require("ashen.ansi").load()
end

return M
