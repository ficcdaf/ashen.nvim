---@meta

---@alias HighlightSpec [HexCode|ColorName?, HexCode|ColorName?, Style?] # Defines a highlight group.

---@alias Style table<string, boolean|string|integer> # Defines the text style of an AshenHighlight.

---@alias HighlightName string # The name of a Neovim highlight group.
---@alias HighlightMap table<HighlightName, HighlightSpec>

---@alias HighlightLink table<HighlightName, HighlightName> # Links first group to second group
---@alias ColorName string

---@alias HexCode string # Hexadecimal color code preceded by a hashtag
---@alias Palette table<ColorName, HexCode>
