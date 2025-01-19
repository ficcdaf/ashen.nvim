local M = {}

---@alias HighlightNormalized table<string, boolean|string?>

---Function normalizes spec into standard format
---@param spec HighlightSpec?
---@return HighlightNormalized
M.normalize_hl = function(spec)
  if not spec or spec == {} then
    return {}
  end
  local norm = {}
  for i = 1, 3 do
    local element = spec[i]
    if type(element) == "string" then
      if i == 1 and element ~= nil then
        norm.fg = element
      elseif i == 2 then
        -- print("set bg " .. name .. " " .. element)
        norm.bg = element
      end
    elseif type(element) == "table" then
      norm = vim.tbl_extend("error", norm, element)
      break
    elseif element == nil then
      -- If nil, skip and continue
      -- print("Skipping nil value")
    else
      vim.notify("Error: invalid Ashen highlight spec for ", vim.log.levels.ERROR)
      return {}
    end
  end
  return norm
end

---Recursively calls "callback" on all
---values in given table. Traverses nested tables.
---@param tbl table
---@param callback fun(k: any, v: any): any
M.deep_traverse = function(tbl, callback)
  for k, v in pairs(tbl) do
    if type(v) == "table" then
      M.deep_traverse(v, callback)
    else
      tbl[k] = callback(k, v)
    end
  end
end

---Function checks whether input matches
---a hexadecimal color code.
---@param str string
---@return boolean
M.is_hex = function(str)
  local match = string.match(str, "^#[%w]+$")
  if match then
    return true
  else
    return false
  end
end


---Function traverses highlight specs and
---enforces various HL rules.
---@param spec HighlightNormalized
M.enforce_hl_rules = function(spec)
  local c = require("ashen.colors")
  local opts = require("ashen.state").opts
  M.deep_traverse(spec, function(k, v)
    -- check if it's a style parameter set to false
    -- in user opts
    local val_type = type(v)
    if val_type == "boolean" and opts.style[k] == false then
      return false
    end
    -- check if string needs to be converted to hex
    if val_type == "string" and not M.is_hex(v) then
      local hex = c[v]
      if type(hex) == "string" then
        return hex
      end
    end
    return v
  end)
end

-- This function sets the highlight groups
-- via Neovim's API. Return value indicates success.
-- It normalizes the specs and converts colors names to
-- hexadecimal values.
---@param name string
---@param spec HighlightSpec|HighlightNormalized?
---@return boolean
M.hl = function(name, spec)
  local theme = require("ashen.theme")
  if spec == {} or spec == nil or theme.link[name] ~= nil then
    return false
  end
  if not M.is_norm(spec) then
    spec = M.normalize_hl(spec)
  end
  ---spec will always be normalized at this point
  ---@cast spec HighlightNormalized
  M.enforce_hl_rules(spec)

  -- check if transparency is enabled
  -- this is too costly to do on each hl, though
  if require("ashen.theme").transparent_bg[name] then
    spec.bg = nil
  end
  -- -- Debugging output to verify the structure
  -- for k, v in pairs(spec) do
  --   if type(k) ~= "string" then
  --     return false
  --   end
  -- end
  vim.api.nvim_set_hl(0, name, spec)
  return true
end

---@param spec HighlightNormalized
---@return HighlightSpec
local function denormalize(spec)
  local fg = spec.fg
  spec.fg = nil
  local bg = spec.bg
  spec.bg = nil
  return { fg, bg, spec }
end

---@param spec HighlightSpec|HighlightNormalized
M.remove_bg = function(spec)
  if not M.is_norm(spec) then
    local norm = M.normalize_hl(spec)
    norm.bg = nil
    return denormalize(norm)
  else
    spec.bg = nil
    return spec
  end
end

function M.link_lang(table, lang)
  for hl, input in pairs(table) do
    local l = input .. "." .. lang
    vim.api.nvim_set_hl(0, hl, { link = l })
  end
end

---Link input to target
---@param inp HighlightName
---@param targ HighlightName
---@param force boolean?
M.link = function(inp, targ, force)
  local ln = require("ashen.state").opts.hl.link
  if force or ln[inp] == nil then
    vim.api.nvim_set_hl(0, inp, { link = targ })
  end
end

---Function checks whether a given spec
---is in normalized form
---@param spec any
---@return boolean
function M.is_norm(spec)
  if type(spec) ~= "table" then
    return false
  end
  for k, _ in pairs(spec) do
    if type(k) == "number" then
      return false
    end
  end
  return true
end

---@param file string
---@return string
M.strip_extension = function(file)
  return file:match("(.+)%..+$")
end

---Helper function to check if a certain
---value is present inside a list.
---@param list any[]
---@param value any
---@return boolean
M.is_in = function(list, value)
  for _, v in ipairs(list) do
    if v == value then
      return true
    end
  end
  return false
end

AshenD = {}
AshenE = {}
Norm = {}

local function merge_map(targ, new)
  for k, v in pairs(new or {}) do
    if targ[k] == nil then
      targ[k] = v
    else
      AshenD[k] = v
      -- AshenD[k] = vim.tbl_deep_extend("force", M.normalize_hl(targ[k]), M.normalize_hl(v))
      if not M.is_norm(v) then
        v = M.normalize_hl(v)
      end
      if not M.is_norm(targ[k]) then
        targ[k] = M.normalize_hl(targ[k])
      end
      -- targ[k] = vim.tbl_deep_extend("force", targ[k], v)
      local temp = vim.tbl_deep_extend("force", targ[k], v)
      targ[k] = denormalize(temp)
      AshenE[k] = targ[k]
    end
  end
end

---@param map HighlightMap
---@param opts Options
M.map_override = function(map, opts)
  if not map then
    return
  end
  if opts.hl.merge_override and opts.hl.merge_override ~= {} then
    merge_map(map, opts.hl.merge_override)
  end
  if opts.hl.force_override and opts.hl.force_override ~= {} then
    for k, v in pairs(opts.hl.force_override or {}) do
      map[k] = v
    end
  end
end

---Utility function merges any number of lists
---skipping duplicate values.
---@param ... any[]
---@return any[]
M.list_merge = function(...)
  local seen = {}
  local merged = {}
  for _, list in ipairs({ ... }) do
    for _, value in ipairs(list) do
      if not seen[value] then
        table.insert(merged, value)
        seen[value] = true
      end
    end
  end
  return merged
end

return M
