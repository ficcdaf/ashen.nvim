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
    local success, result = pcall(function()
      return debug.getinfo(require("ashen.plugins").load).source:sub(2)
    end)

    local module_path
    if success then
      module_path = result
    else
      error("Fatal error in ashen.nvim: could not retrieve plugins path")
    end
    -- we get its parent directory
    local plugins_dir = vim.fn.fnamemodify(module_path, ":h")
    -- read list of files in this folder
    local files = vim.fn.readdir(plugins_dir)
    local plugins = {}
    for _, file in ipairs(files) do
      -- all lua files are plugin integrations,
      -- except for init.lua
      if file:match("%.lua$") and not file:match("init%.lua") then
        -- strip the extension to get the module name
        local name = util.strip_extension(file)
        table.insert(plugins, name)
      end
    end
    valid_plugins = plugins
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
  for _, name in ipairs(names) do
    if not util.is_in(disabled, name) then
      table.insert(plugins, require("ashen.plugins." .. name))
    end
  end
  return plugins
end

local function set_highlights(plugin)
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

---Loads a specific plugin integration.
---Accepts a plugin name, or a plugin integration spec.
---@param plugin string|table
M.load_plugin = function(plugin)
  local opts = require("ashen.state").opts
  local module
  if type(plugin) == "string" then
    if not util.is_in(M.get_valid_plugins(), plugin) then
      vim.notify("Ashen: " .. plugin .. " is not a valid plugin integration!", vim.log.levels.ERROR)
      return
    end
    module = require("ashen.plugins." .. plugin)
  elseif type(plugin) == "table" then
    module = plugin
  end
  if module.map then
    util.map_override(module.map, opts)
  end
  if module.autocmd ~= nil then
    vim.api.nvim_create_autocmd({ module.autocmd.event }, {
      callback = function()
        set_highlights(module)
      end,
      pattern = module.autocmd.pattern,
    })
  elseif module.map or module.link then
    set_highlights(module)
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
end

return M
