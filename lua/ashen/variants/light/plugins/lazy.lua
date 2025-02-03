local M = {}

M.map = {
  LazySpecial = { "red_ember" },
  LazyReasonEvent = { "orange_blaze" },
  LazyReasonCmd = { "orange_smolder" },
  LazyReasonKeys = { "orange_glow" },
  LazyReasonFt = { "red_ember" },
  LazyReasonImport = { "red_ember" },
  LazyReasonPlugin = { "red_ember", { bold = true } },
  LazyReasonRequire = { "red_glowing" },
  LazyComment = { "g_5", { bold = true } },
  LazyLocal = { "orange_smolder" },
  LazyProgressTodo = { "orange_blaze" },
  LazyProgressDone = { "g_4" },
  LazyProp = { "g_4", { italic = true } },
  LazyDir = { "orange_smolder" },
  LazyUrl = { "red_glowing", { italic = true } },
  LazyValue = { "orange_glow" },
}

return M
