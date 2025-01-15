local util = require("ashen.util")
local M = {}
local default_languages = {
  -- "python",
  "go",
}

local function get_languages(languages)
  local out = {}
  for _, language in ipairs(languages) do
    table.insert(out, require("ashen.languages." .. language))
  end
  return out
end

local function setup_language(lang)
  if lang.map ~= nil then
    for name, opt in pairs(lang.map) do
      util.hl(name, opt)
    end
  end
  if lang.link ~= nil and lang.dot_link == nil then
    for name, targ in pairs(lang.link) do
      util.link(name, targ)
    end
  elseif lang.link ~= nil and lang.dot_link then
    util.link_lang(lang.link, lang.name)
  end
end

M.load = function()
  local languages = get_languages(default_languages)

  for _, lang in ipairs(languages) do
    if lang.lsp_attach then
      -- something
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "gopls" then
            setup_language(lang)
          end
        end,
      })
    else
      setup_language(lang)
    end
  end
end

return M
