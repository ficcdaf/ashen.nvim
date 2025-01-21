local M = {}

M.map = {
  ["@org.keyword.todo"] = { "red_ember", { bold = true } },
  ["@org.keyword.done"] = { "g_6", { bold = true } },
  ["@org.plan"] = { "red_ember" },
  ["@org.timestamp.active"] = { "orange_smolder" },
  ["@org.headline.level1"] = { "red_glowing", { bold = true } },
  ["@org.headline.level2"] = { "orange_blaze", { bold = true } },
  ["@org.headline.level3"] = { "red_glowing", { bold = true } },
  ["@org.headline.level4"] = { "orange_blaze", { bold = true } },
  ["@org.headline.level5"] = { "red_glowing", { bold = true } },
  ["@org.headline.level6"] = { "orange_blaze", { bold = true } },
  ["@org.headline.level7"] = { "red_glowing", { bold = true } },
  ["@org.headline.level8"] = { "orange_blaze", { bold = true } },
  ["@org.properties"] = { "g_5" },
  ["@org.properties.name"] = { "g_4", { bold = true } },
  ["@org.drawer"] = { "blue" },
  -- agenda
  ["@org.agenda.scheduled"] = { "orange_blaze" },
  ["@org.agenda.scheduled_past"] = { "orange_golden", { bold = true } },
  ["@org.agenda.day"] = { "g_4" },
  ["@org.agenda.today"] = { "g_3", { bold = true } },
  ["@org.agenda.weekend"] = { "g_5" },
  ["@org.agenda.deadline"] = { "red_flame", { bold = true } },
}

return M
