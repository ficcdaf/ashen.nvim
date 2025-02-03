local M = {}

M.autocmd = {
  pattern = "markdown",
  event = "FileType",
}

M.map = {
  ObsidianRefText = { "red_kindling" },
  ObsidianRef = { "red_ember" },
  ObsidianBullet = { "orange_blaze" },
  ObsidianDone = { "orange_blaze" },
  ObsidianTodo = { "orange_glow" },
  obsidiantag = { "blue" },
  ObsidianTag = { "blue" },
}
return M
