local util = require("ashen.util")
local M = {}

---Returns a list of submodule names with valid integrations.
---@param module string
---@return string[]
M.get_valid_integrations = function(module)
  -- we get the path of the plugins module file
  local success, result = pcall(function()
    local variant = require("ashen.state").variant
    return debug.getinfo(require("ashen.variants." .. variant .. "." .. module)).source:sub(2)
  end)

  local module_path
  if success then
    module_path = result
  else
    error("Fatal error in ashen.nvim: could not retrieve " .. module .. " path\n" .. result)
  end
  -- we get its parent directory
  local mod_dir = vim.fn.fnamemodify(module_path, ":h")
  -- read list of files in this folder
  local files = vim.fn.readdir(mod_dir)
  local sub = {}
  for _, file in ipairs(files) do
    -- all lua files are integrations,
    -- except for init.lua
    if file:match("%.lua$") and not file:match("init%.lua") then
      -- strip the extension to get the module name
      local name = util.strip_extension(file)
      table.insert(sub, name)
    end
  end
  return sub
end

---TODO: define a submodule class

---@param submodule table
function M.execute(submodule)
  if submodule.map ~= nil then
    for name, spec in pairs(submodule.map) do
      util.hl(name, spec)
    end
  end
  if submodule.link ~= nil then
    for name, target in pairs(submodule.link) do
      util.link(name, target)
    end
  end
  if submodule.exec ~= nil and type(submodule.exec) == "function" then
    submodule.exec()
  end
end

---Loads a specific integration.
---Accepts a name, or an integration spec.
---@param integration string|table
---@param module string
M.load_submodule = function(integration, module)
  local opts = require("ashen.state").opts
  local variant = require("ashen.state").variant
  local submodule
  if type(integration) == "string" then
    if not util.is_in(M.get_valid_integrations(module), integration) then
      vim.notify("Ashen: " .. integration .. " is not a valid integration!", vim.log.levels.ERROR)
      return
    end
    submodule = require("ashen.variants." .. variant .. "." .. module .. "." .. integration)
  elseif type(integration) == "table" then
    submodule = integration
  end
  if submodule.map then
    util.map_override(submodule.map, opts)
  end
  if submodule.autocmd ~= nil then
    vim.api.nvim_create_autocmd({ submodule.autocmd.event }, {
      callback = function()
        M.execute(submodule)
      end,
      pattern = submodule.autocmd.pattern,
    })
  elseif submodule.map or submodule.link or submodule.exec then
    M.execute(submodule)
  end
end

---Load plugin integrations
-- M.load = function()
--   local p = require("ashen.state").opts.plugins
--   local plugins = {}
--   if p.autoload then
--     if #p.override > 0 and validate_override() then
--       disabled = util.list_merge(p.override, disabled)
--     end
--     plugins = get_autoload_plugins()
--   else
--     if #p.override > 0 and validate_override() then
--       plugins = p.override
--     end
--   end
--   for _, plugin in ipairs(plugins) do
--     M.load_submodule(plugin)
--   end
-- end

return M
