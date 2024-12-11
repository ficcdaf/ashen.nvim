# Ashen

![](assets/preview.png)

Ashen is a warm, muted colorscheme that evokes the feeling of embers sizzling out in an old fire pit.

## Installation

Using [lazy.nvim](https://lazy.folke.io/):

```lua
{
 "ficcdaf/ashen.nvim",
 lazy = false,
 priority = 1000,
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
-- in lua/plugins/colorscheme.lua
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

Ashen supports the following plugins:

- nvim-cmp
- flash.nvim
- lualine
- obsidian.nvim
- minimap.vim
- telescope.nvim

## Configuration

### Lualine

Ashen comes with a preconfigured Lualine theme that includes a word counter for Markdown, Text, and Latex files, as well as optional [noice.nvim](https://github.com/folke/noice.nvim) and [pomo.nvim](https://github.com/epwalsh/pomo.nvim) support (if you have those plugins installed.) The following is an example of how to configure Lualine to use Ashen:

```lua
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "ficcdaf/ashen.nvim",
  },
  opts = require("ashen.plugins.lualine").lualine_opts,
}
```

## Acknowledgements

Ashen started out as a (very heavily) customized version of [nvim-noirbuddy](https://github.com/jesseleite/nvim-noirbuddy), so big thanks to jesseleite for the inspiration as well as the lualine configuration.
