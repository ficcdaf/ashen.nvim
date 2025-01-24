local M = {}
local c = require("ashen.colors")
M.map = {
  ["lualine_b_diagnostics_error_normal"] = "red_flame",
  ["lualine_b_diagnostics_error_insert"] = "red_flame",
  ["lualine_b_diagnostics_error_visual"] = "red_flame",
  ["lualine_b_diagnostics_error_replace"] = "red_flame",
  ["lualine_b_diagnostics_error_command"] = "red_flame",
  ["lualine_b_diagnostics_error_terminal"] = "red_flame",
  ["lualine_b_diagnostics_error_inactive"] = "red_flame",

  ["lualine_b_diagnostics_warn_normal"] = "orange",
  ["lualine_b_diagnostics_warn_insert"] = "orange",
  ["lualine_b_diagnostics_warn_visual"] = "orange",
  ["lualine_b_diagnostics_warn_replace"] = "orange",
  ["lualine_b_diagnostics_warn_command"] = "orange",
  ["lualine_b_diagnostics_warn_terminal"] = "orange",
  ["lualine_b_diagnostics_warn_inactive"] = "orange",

  ["lualine_b_diagnostics_info_normal"] = "g_2",
  ["lualine_b_diagnostics_info_insert"] = "g_2",
  ["lualine_b_diagnostics_info_visual"] = "g_2",
  ["lualine_b_diagnostics_info_replace"] = "g_2",
  ["lualine_b_diagnostics_info_command"] = "g_2",
  ["lualine_b_diagnostics_info_terminal"] = "g_2",
  ["lualine_b_diagnostics_info_inactive"] = "g_2",

  ["lualine_b_diagnostics_hint_normal"] = "g_3",
  ["lualine_b_diagnostics_hint_insert"] = "g_3",
  ["lualine_b_diagnostics_hint_visual"] = "g_3",
  ["lualine_b_diagnostics_hint_replace"] = "g_3",
  ["lualine_b_diagnostics_hint_command"] = "g_3",
  ["lualine_b_diagnostics_hint_terminal"] = "g_3",
  ["lualine_b_diagnostics_hint_inactive"] = "g_3",
}

M.link = {
  ["lualine_b_diff_added_normal"] = "DiffAdd",
  ["lualine_b_diff_added_insert"] = "DiffAdd",
  ["lualine_b_diff_added_visual"] = "DiffAdd",
  ["lualine_b_diff_added_replace"] = "DiffAdd",
  ["lualine_b_diff_added_command"] = "DiffAdd",
  ["lualine_b_diff_added_terminal"] = "DiffAdd",
  ["lualine_b_diff_added_inactive"] = "DiffAdd",

  ["lualine_b_diff_modified_normal"] = "DiffChange",
  ["lualine_b_diff_modified_insert"] = "DiffChange",
  ["lualine_b_diff_modified_visual"] = "DiffChange",
  ["lualine_b_diff_modified_replace"] = "DiffChange",
  ["lualine_b_diff_modified_command"] = "DiffChange",
  ["lualine_b_diff_modified_terminal"] = "DiffChange",
  ["lualine_b_diff_modified_inactive"] = "DiffChange",

  ["lualine_b_diff_removed_normal"] = "DiffDelete",
  ["lualine_b_diff_removed_insert"] = "DiffDelete",
  ["lualine_b_diff_removed_visual"] = "DiffDelete",
  ["lualine_b_diff_removed_replace"] = "DiffDelete",
  ["lualine_b_diff_removed_command"] = "DiffDelete",
  ["lualine_b_diff_removed_terminal"] = "DiffDelete",
  ["lualine_b_diff_removed_inactive"] = "DiffDelete",
}

M.theme = {

  normal = {
    a = { fg = c.g_2, bg = c.g_7 },
    b = { fg = c.g_3, bg = c.g_8 },
    c = { fg = c.g_3, bg = c.g_9 },
  },
  insert = { a = { fg = c.background, bg = c.red_ember } },
  visual = { a = { fg = c.background, bg = c.red_kindling } },
  replace = { a = { fg = c.background, bg = c.red_ember } },
  inactive = {
    a = { fg = c.g_6, bg = c.g_9 },
    b = { fg = c.g_6, bg = c.g_9 },
    c = { fg = c.g_6, bg = c.g_9 },
  },
}

local modes = {
  NORMAL = "NRM",
  INSERT = "INS",
  VISUAL = "VIS",
  ["V-LINE"] = "V-L",
  ["V-BLOCK"] = "V-B",
  SELECT = "SEL",
  ["S-LINE"] = "S-L",
  ["S-BLOCK"] = "S-B",
  COMMAND = "CMD",
  TERMINAL = "TRM",
  ["O-PENDING"] = "O-P",
  EX = "EX",
  REPLACE = "REP",
  ["V-REPLACE"] = "V-R",
}

local word_count_filetypes = {
  markdown = true,
  txt = true,
  tex = true,
}

local wc_cache = ""
local function update_word_count()
  local ft = vim.bo.filetype
  local wc = vim.api.nvim_eval("wordcount()")
  if word_count_filetypes[ft] then
    if wc["visual_words"] then
      wc_cache = "vw:" .. wc["visual_words"]
    else
      wc_cache = "w:" .. wc["words"]
    end
  else
    wc_cache = ""
  end
end

local noice_available, noice = pcall(require, "noice")
local noice_status = noice_available and {
  noice.api.status.mode.get,
  cond = noice.api.status.mode.has,
} or {}

M.sections = {
  lualine_a = {
    {
      "mode",
      fmt = function(str)
        return modes[str] or str
      end,
    },
    noice_status,
    function()
      local ok, pomo = pcall(require, "pomo")
      if not ok then
        return ""
      end

      local timer = pomo.get_first_to_finish()
      if timer == nil then
        return ""
      end

      return "󰄉 " .. tostring(timer)
    end,
  },
  lualine_b = { "branch", "diff" },
  lualine_c = { { "filename", path = 1 } },
  lualine_x = {
    "diagnostics",
    { "filetype", colored = false },
    {
      function()
        update_word_count()
        return wc_cache
      end,
    },
  },
  lualine_y = { "progress" },
  lualine_z = { {
    "location",
    fmt = function(str)
      return string.match(str, "^[^:]+")
    end,
  } },
}

M.inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = { { "filename", path = 1 } },
  lualine_x = { "location" },
  lualine_y = {},
  lualine_z = {},
}

M.lualine_opts = {
  options = {
    theme = M.theme,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = M.sections,
  inactive_sections = M.inactive_sections,
}

return M
