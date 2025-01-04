# Ashen

Coding is already hard on the brain, so it should at least be easy on the eyes. Ashen is a warm, muted colorscheme that evokes the feeling of embers sizzling out in an old fire pit. It features red & orange tones, plenty of grayscale, and hints of teal.

![Lua, Python, and Go code in the Ashen theme.](assets/preview.png "Lua, Python, and Go code in the Ashen theme.")

> [!WARNING]
> This theme is still in early development: the palette and theming may be subject to change.

## Contents

<!--toc:start-->

- [Features](#features)
- [Installation](#installation)
- [Plugins](#plugins)
- [Configuration](#configuration)
- [Plugin Configuration](#plugin-configuration)
- [Extras](#extras)
- [Acknowledgements](#acknowledgements)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
<!--toc:end-->

## Features

- Warm, cozy palette that's easy on the eyes.
- Clear differentiation of errors and warnings.
- Supports a number of [plugins](#plugins).
- Fast load time.
- Actively developed.

## Installation

Using [lazy.nvim](https://lazy.folke.io/):

```lua
{
  "ficcdaf/ashen.nvim",
  lazy = false,
  priority = 1000,
  -- configuration is optional!
  opts = {
    -- your settings here
  },
}
```

You can load Ashen anywhere in your Neovim configuration:

```lua
vim.cmd("colorscheme ashen")
-- You may call the load function as well
require("ashen").load()
```

If you're using [LazyVim](https://www.lazyvim.org/), I recommend the following:

```lua
return {
  { "ficcdaf/ashen.nvim" },
  -- Configure LazyVim to load Ashen
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ashen",
    },
  }
}
```

## Plugins

> [!WARNING]
> The following may be incomplete! Please check `lua/ashen/plugins` for an up-to-date list of supported plugins. I will endeavour to update this README frequently.

Many plugins are already "supported" because they use standard Neovim highlight groups. However, some plugins require bespoke support. Additionally, some plugins may require extra setup to look good with Ashen. Please see [Plugin Configuration](#plugin-configuration) for more details.

Ashen explicitly supports the following plugins:

- blink.cmp
- nvim-cmp
- flash.nvim
- lualine
- mini.icons
- trailblazer.nvim
- obsidian.nvim
- oil.nvim
- render-markdown.nvim
- telescope.nvim
- minimap.vim

## Configuration

> [!WARNING]
> If you choose to set any options, please note that `setup` _only_ sets up
> the configuration and does **not** load the theme! You must call `colorscheme ashen`
> or `require("ashen").load()` _after_ `setup`!

You can pass an options table to the `setup` function to configure Ashen, the same you would any other plugin. If you use `lazy.nvim`, you can set options as shown in [installation](#installation)!

```Lua
require("ashen").setup({
  -- your settings here
})
-- theme must be loaded *after* setup!
vim.cmd("colorscheme ashen")
```

The following default settings are provided. Any settings not self-explanatory will be expanded on below. Any provided settings will be merged with the defaults.

```Lua
{
  --- override palette, see below
  ---@type Palette
  ---@field [ColorName] HexCode
  colors = {},
  -- override highlights
  hl = {
    ---Overwrite; omitted fields are cleared
    ---@type HighlightMap
    force_override = {},
    ---Merge fields with defaults
    ---@type HighlightMap
    merge_override = {},
  },
  -- force clear other highlights
  -- even if no other theme is set
  -- (useful for debugging)
  force_hi_clear = false,
  -- enable termguicolors on load (recommended)
  termguicolors = true,
}
```

### Palette Override

You can override any color in Ashen's palette, or set new colors entirely. The `colors` setting accepts a table of `ColorName = HexCode` pairs, where they are both strings, with `ColorName` corresponding to an Ashen color, and `HexCode` being a `#` prefixed hexadecimal color code. For an list of available color names, please see [colors.lua](./lua/ashen/colors.lua).

Please see the following example:

```Lua
{
  colors = {
    background = "#000000",
    red_ember = "#933737"
  },
}
```

> [!TIP]
> Made a palette you're proud of? It could become Ashen's next "theme variant" -- don't be afraid to open a feature request for it!

### Highlight Override

Ashen's highlight groups are defined like so:

```Lua
---@alias HighlightSpec [FgHexCode?, BgHexCode?, Style?]
-- The colors *must* be in this ^^^ order. If you want
-- to set a background but no foreground, you MUST pass
-- nil for the FgHexCode!
-- example:
{ "#FFFFFF" } -- set only foreground
{ "#FFFFFF", "#000000" } -- set foreground and background
{ nil, "#000000" } -- set only background

-- Please see `:h nvim_set_hl()` -> {val}
-- for the possible style table options.
---@alias Style table<string, boolean|string|integer>
-- example:
{ bold = true, underline = true }

-- You may pass a style table as the LAST element
-- of a HighlightSpec.
{ "#FFFFFF", "#000000", { bold = true, underline = true } }
-- The style table can be the only element, too.
{ { bold = true, underline = true } }


---@alias HighlightMap table<HighlightName, HighlightSpec>
-- Example of a HighlightMap:
{
  Normal = { "#FFFFFF", "#000000", { bold = true, underline = true } },
  ["@function.macro"] = { "#B14242" },
}
```

Users can override Ashen's highlight group definitions, or set new ones entirely. There are two options under the `hl` setting: `force_override` and `merge_override`.

The former will _completely_ overwrite the given highlight group; existing properties are **not** preserved. An empty table `{}` means Ashen will not touch that highlight group.

The latter will _merge_ properties: it will override _only_ the properties you specify, and keep non-conflicting Ashen defaults.

```Lua
-- full example
hl = {
  -- overwrite every field
  force_override = {
    Normal = { "#FFFFFF", "#000000", { bold = true, underline = true } },
  },
  -- keep untouched fields
  merge_override = {
    ["@function.macro"] = { "#B14242" },
  },
},
```

## Plugin Configuration

### Lualine

Ashen comes with a preconfigured Lualine theme that includes a word counter for Markdown, Text, and Latex files. Optionally, [noice.nvim](https://github.com/folke/noice.nvim) is used to indicate Macro recording status, and [pomo.nvim](https://github.com/epwalsh/pomo.nvim) is supported. The following is an example of how to configure Lualine to use Ashen:

```lua
return {
  "nvim-lualine/lualine.nvim",
  -- ensure Ashen is loaded first
  dependencies = {
    "ficcdaf/ashen.nvim",
  },
  opts = function()
    local ashen = require("ashen.plugins.lualine").lualine_opts
    -- you can set any other options
    -- expected by lualine, since this
    -- table will be passed directly to `setup`
    ashen.extensions = { "lazy", "fzf" }
    return ashen
  end,
}
```

> I am working on improving the word counter and releasing it as a separate plugin. When that happens, Ashen will be updated to support it out of the box.

### Trailblazer.nvim

Trailblazer tends to overwrite the highlight groups set by Ashen. Therefore, you may need to invoke Ashen's Trailblazer setup immediately _after_ loading Trailblazer. Please see the following example:

```lua
return {
  "LeonHeidelbach/trailblazer.nvim",
  event = "UIEnter",
  -- ensure Ashen is loaded first
  dependencies = {
    "ficcdaf/ashen.nvim",
  },
  config = function()
    require("trailblazer").setup({
      -- your Trailblazer setup here
    })
    -- This ensures Ashen's HL groups are set up
    -- AFTER Trailblazer sets its own.
    require("ashen.plugins").setup("trailblazer")
  end,
}
```

### Render-markdown.nvim

Ashen will support `render-markdown` OOTB with no additional configuration. You may optionally consider including the following icons in your setup. Note they may not render properly in all browsers.

```lua
-- as part of render-markdown.nvim setup
opts = {
  bullet = {
    -- cleaner bullet points
    icons = { "•", "∙" },
  },
  heading = {
    -- Icons that say H1, H2, etc.
    icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
  },

}
```

## Extras

Extras can be found [here](./extras/). You can install them like you would any other theme in the respective application.

The following extras are available:

- Ghostty
- Kitty
- Alacritty
- Windows Terminal

## Acknowledgements

Ashen was inspired by [nvim-noirbuddy](https://github.com/jesseleite/nvim-noirbuddy).

## Roadmap

Please refer to the [issues](https://github.com/ficcdaf/ashen.nvim/issues) page for an up-to-date roadmap.

## Contributing

I welcome contributions. If you want a certain plugin or extra to be added, please open an issue and I'll get to it as soon as I can. If you're interested in contributing, you're welcome to take a stab at any of the [issues](https://github.com/ficcdaf/ashen.nvim/issues).
