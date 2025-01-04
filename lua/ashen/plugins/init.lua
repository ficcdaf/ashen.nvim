local util = require("ashen.util")
local M = {}
local default_plugins = {
  "cmp",
  "lualine",
  "flash",
  "telescope",
  "obsidian",
  "minimap",
  "blink",
  "oil",
  "render-markdown",
  "mini-icons",
  -- "trailblazer",
}

---@param plugins string[]?
local function get_plugins(plugins)
  if not plugins then
    plugins = default_plugins
  end
  local out = {}
  for _, plugin in ipairs(plugins) do
    table.insert(out, require("ashen.plugins." .. plugin))
  end
  return out
end

---Setup plugin-specific highlight groups on demand.
---@param plugins string | string[]?
M.setup = function(plugins)
  if plugins then
    if type(plugins) == "string" then
      plugins = { plugins }
    end
  end
  local plugin_modules = get_plugins(plugins)
  -- local plugins = { require("ashen.plugins." .. "flash") }
  for _, plugin in ipairs(plugin_modules) do
    local function set()
      if plugin.map ~= nil then
        for name, spec in pairs(plugin.map) do
          util.hl(name, spec)
        end
      end
      if plugin.link ~= nil then
        for name, target in pairs(plugin.link) do
          util.link(name, target)
        end
      end
    end

    if plugin.autocmd ~= nil then
      vim.api.nvim_create_autocmd({ plugin.autocmd.event }, {
        callback = set,
        pattern = plugin.autocmd.pattern,
      })
    else
      set()
    end
  end
end

return M
