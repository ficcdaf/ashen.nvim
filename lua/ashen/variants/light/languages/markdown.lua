local M = {}

M.map = {
  ["@markup.link"] = { "red_ember", nil },
  ["@markup.link.label"] = { "red_glowing", nil },
  ["@markup.link.url"] = { "red_glowing", nil },
  ["@markup.list"] = { "orange_glow", nil },
  ["@markup.quote"] = { italic = true },
  ["@markup.math"] = { bold = true },
  ["@markup.raw"] = { "g_4", "g_10" },
}

return M
