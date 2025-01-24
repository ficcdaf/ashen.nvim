local M = {}

M.map = {
  BlinkCmpDoc = { nil, "g_9" },
  BlinkCmpDocBorder = { nil, "g_9" },
  -- CursorLine = {},
  -- Search = {},
}

-- Require this for blink.cmp config
-- M.winhighlight = "FloatBorder:CmpDocumentation,NormalFloat:CmpDocumentation"
-- M.winhighlight = "CursorLine:BlinkCmpDocCursorLine,Search:None"
M.winhighlight =
  "BlinkCmpDoc:BlinkCmpDoc,BlinkCmpDocBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None"
return M
