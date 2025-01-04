local M = {}

---@alias HighlightNormalized table<string, boolean|string?>

---Function normalizes spec into standard format
---@param spec HighlightSpec?
---@return HighlightNormalized
M.normalize_hl = function(spec)
  if spec == nil or spec == {} then
    return {}
  end
  local norm = {}
  for i = 1, #spec do
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

-- This function sets the highlight groups
-- via Neovim's API. Return value indicates success.
---@param name string
---@param spec HighlightSpec|HighlightNormalized?
---@return boolean
M.hl = function(name, spec)
  if spec == {} or spec == nil then
    return false
  end
  if not M.is_norm(spec) then
    spec = M.normalize_hl(spec)
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

function M.link_lang(table, lang)
  for hl, input in pairs(table) do
    local l = input .. "." .. lang
    vim.api.nvim_set_hl(0, hl, { link = l })
  end
end

M.link = function(inp, targ)
  vim.api.nvim_set_hl(0, inp, { link = targ })
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

return M
