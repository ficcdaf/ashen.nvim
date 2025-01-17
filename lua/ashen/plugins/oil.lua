local M = {}
local c = require("ashen.colors")

M.map = {
  OilDir = { c.g_1 },
  OilFile = { c.g_4 },
  OilLink = { c.red_ember },
  OilCopy = { c.g_2 },
  OilCreate = { c.g_2 },
  OilChange = { c.orange_blaze },
  OilMove = { c.orange_blaze },
  OilDelete = { c.red_flame },
}

return M
