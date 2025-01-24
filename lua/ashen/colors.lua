local function get_palette()
  local variant = require("ashen.state").variant
  return require("ashen.variants." .. variant .. ".colors")
end

return get_palette()
