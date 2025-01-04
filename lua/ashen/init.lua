local M = {}

M.lazyvim = false

-- default settings
--- @class Options table
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
  },
  -- force clear other highlights
  force_hi_clear = false,
  -- enable termguicolors on load
  termguicolors = true,
}

-- Merge user options with defaults
M.setup = function(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
  require("ashen.colors").setup(M.opts)
  require("ashen.theme").setup(M.opts)
end

-- Load the theme
M.load = function()
  local opts = M.opts
  M.lazyvim = pcall(require, "lazyvim")
  if vim.g.colors_name or M.opts.force_hi_clear then
    vim.cmd("hi clear")
  end
  vim.g.colors_name = "ashen"
  vim.o.termguicolors = opts.termguicolors
  vim.api.nvim_command(string.format("set background=%s", "dark"))
  require("ashen.theme").load()
  require("ashen.plugins").setup()
  require("ashen.autocmds").setup()
  require("ashen.languages").setup()
end

return M
