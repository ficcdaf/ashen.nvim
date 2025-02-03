local M = {}

M.map = {
  AshenMinimapCursor = { "red_kindling", "g_9" },
  AshenMinimapRange = { "red_ember", "background" },
  -- TODO: Add colors for the git colors
}
vim.g.minimap_range_color = "AshenMinimapRange"
vim.g.minimap_cursor_color = "AshenMinimapCursor"
return M
