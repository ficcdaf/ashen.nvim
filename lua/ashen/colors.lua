local M = {}

---@alias AshenColor string
---| "red_flame" # Brightest, most intense red
---| "red_kindling" # Light, warm red
---| "red_glowing" # Slightly deeper glowing red
---| "red_burnt_crimson" # Muted crimson red
---| "red_ember" # Deep, smoldering ember red
---| "red_brick" # Muted, earthy brick red
---| "red_deep_ember" # Dark, deep ember red
---| "red_ashen" # Cool, ashen red
---| "orange_glow" # Bright, glowing orange
---| "orange_blaze" # Vibrant blaze orange
---| "orange_smolder" # Dark, smoldering orange
---| "orange_golden" # Vibrant golden tone
---| "blue" # Muted teal, soft and unobtrusive
---| "blue_dark" # Dark teal
---| "background" # Dark background
---| "g_0"  # Greyscale, g[0 -> 10] [bright -> dark]
---| "g_1"  # Greyscale, g[0 -> 10] [bright -> dark]
---| "g_2"  # Greyscale, g[0 -> 10] [bright -> dark]
---| "g_3"  # Greyscale, g[0 -> 10] [bright -> dark]
---| "g_4"  # Greyscale, g[0 -> 10] [bright -> dark]
---| "g_5"  # Greyscale, g[0 -> 10] [bright -> dark]
---| "g_6"  # Greyscale, g[0 -> 10] [bright -> dark]
---| "g_7"  # Greyscale, g[0 -> 10] [bright -> dark]
---| "g_8"  # Greyscale, g[0 -> 10] [bright -> dark]
---| "g_9"  # Greyscale, g[0 -> 10] [bright -> dark]
---| "g_10" # Greyscale, g[0 -> 10] [bright -> dark]

---@alias HexCode string # Hexadecimal color code preceded by a hashtag

---@class AshenPalette
---@field [AshenColor] HexCode
M.colors = {
  red_flame = "#C53030", -- Brightest, most intense red
  red_kindling = "#BD4C4C", -- Light, warm red
  red_glowing = "#C25757", -- Slightly deeper glowing red
  red_burnt_crimson = "#A84848", -- Muted crimson red
  red_ember = "#933737", -- Deep, smoldering ember red
  red_brick = "#853D3D", -- Muted, earthy brick red
  red_deep_ember = "#7A2E2E", -- Dark, deep ember red
  red_ashen = "#6F2929", -- Cool, ashen red
  orange_glow = "#D87C4A", -- Bright, glowing orange
  orange_blaze = "#C4693D", -- Vibrant blaze orange
  orange_smolder = "#B25830", -- Dark, smoldering orange
  orange_golden = "#E5A72A",
  blue = "#3A6E6E", -- Muted teal, soft and unobtrusive
  blue_dark = "#1A3F3F", -- Dark teal, ideal for subtle backgrounds
  background = "#121212",
  g_0 = "#ffffff",
  g_1 = "#f5f5f5",
  g_2 = "#d5d5d5",
  g_3 = "#b4b4b4",
  g_4 = "#a7a7a7",
  g_5 = "#949494",
  g_6 = "#737373",
  g_7 = "#535353",
  g_8 = "#323232",
  g_9 = "#212121",
  g_10 = "#121212",
}
return M.colors

-- #D87C4A
-- #C4693D
-- #B25830
-- Deep Ember Red: #7A2E2E
-- A darker shade to add depth and contrast.
--
-- Burnt Crimson: #A84848
-- Slightly lighter and less saturated than your red_light.
--
-- Glowing Red: #C25757
-- A warmer, softer red to evoke the glowing embers.
--
-- Muted Brick Red: #853D3D
-- Fits well with your existing reds but offers a slightly earthy tone.
--
-- Ashen Red: #6F2929
-- A muted, subdued red that aligns with the theme of cooled embers.
