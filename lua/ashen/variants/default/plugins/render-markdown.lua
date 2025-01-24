local M = {}

-- M.autocmd = {
--   pattern = "markdown",
--   event = "FileType",
-- }

M.link = {
  RenderMarkdownBullet = "@markup.list",
}

M.map = {
  RenderMarkdownH1Bg = { "red_ember", "g_10" },
  RenderMarkdownH2Bg = { "red_ember", "g_10" },
  RenderMarkdownH3Bg = { "red_ember", "g_10" },
  RenderMarkdownH4Bg = { "red_ember", "g_10" },
  RenderMarkdownH5Bg = { "red_ember", "g_10" },
  RenderMarkdownH6Bg = { "red_ember", "g_10" },
  RenderMarkdownH1 = { "red_ember" },
  RenderMarkdownH2 = { "red_ember" },
  RenderMarkdownH3 = { "red_ember" },
  RenderMarkdownH4 = { "red_ember" },
  RenderMarkdownH5 = { "red_ember" },
  RenderMarkdownH6 = { "red_ember" },
  RenderMarkdownCode = { nil, "g_11" },
  RenderMarkdownCodeInline = { "g_2", "g_11" },
  RenderMarkdownQuote = { "red_kindling" },
  RenderMarkdownMath = { "orange_glow" },
  RenderMarkdownTodo = { "orange_blaze" },
}
return M
