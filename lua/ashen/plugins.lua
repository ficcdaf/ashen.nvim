local util = require("ashen.util")
local M = {}

---@type string[]
local disabled = {
  "trailblazer",
}

local valid_plugins = nil

---Returns a list of plugin names with valid integrations.
---@param force boolean? Force refresh cache of valid plugins
---@return string[]
M.get_valid_plugins = function(force)
  if not valid_plugins or force then
    -- we get the path of the plugins module file
    local sub = require("ashen.submodules")
    valid_plugins = sub.get_valid_integrations("plugins")
  end
  return valid_plugins
end

---Validates whether `opts.plugin.override`
---is a list of valid plugin names.
---@return boolean
local function validate_override()
  local opts = require("ashen.state").opts
  for _, plugin in ipairs(opts.plugins.override) do
    if not util.is_in(M.get_valid_plugins(), plugin) then
      vim.notify("Ashen: " .. plugin .. " is not valid, ignoring override settings...", vim.log.levels.ERROR)
      return false
    end
  end
  return true
end

---Function reads plugin modules from plugin directory
---@return table[]
local function get_autoload_plugins()
  local plugins = {}
  local names = M.get_valid_plugins()
  local variant = require("ashen.state").variant
  for _, name in ipairs(names) do
    if not util.is_in(disabled, name) then
      table.insert(plugins, require("ashen.variants." .. variant .. ".plugins." .. name))
    end
  end
  return plugins
end

---Loads a specific plugin integration.
---Accepts a plugin name, or a plugin integration spec.
---@param plugin string|table
M.load_plugin = function(plugin)
  require("ashen.submodules").load_submodule(plugin, "plugins")
end

---Registers `require` loaders in the form `ashen.plugins.plugin_name`
---pointing to `ashen.variants.variant_name.plugins.plugin_name`
M.register_loaders = function()
  for _, plugin in ipairs(M.get_valid_plugins()) do
    package.preload["ashen.plugins." .. plugin] = function()
      local variant = require("ashen.state").variant
      return require("ashen.variants." .. variant .. ".plugins." .. plugin)
    end
  end
end

---Load plugin integrations
M.load = function()
  local p = require("ashen.state").opts.plugins
  local plugins = {}
  if p.autoload then
    if #p.override > 0 and validate_override() then
      disabled = util.list_merge(p.override, disabled)
    end
    plugins = get_autoload_plugins()
  else
    if #p.override > 0 and validate_override() then
      plugins = p.override
    end
  end
  for _, plugin in ipairs(plugins) do
    M.load_plugin(plugin)
  end
  M.register_loaders()
end

return M
