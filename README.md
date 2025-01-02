# Ashen

Coding is already hard on the brain, so it should at least be easy on the eyes. Ashen is a warm, muted colorscheme that evokes the feeling of embers sizzling out in an old fire pit. It features red & orange tones, plenty of grayscale, and hints of teal.

![Lua, Python, and Go code in the Ashen theme.](assets/preview.png "Lua, Python, and Go code in the Ashen theme.")

> [!WARNING]
> This theme is still in early development: the palette and theming may be subject to change. By nature of this being my "dream theme", Ashen is opinionated, and some stylistic choices and implementations are likely to change at some point. Thank you for your understanding, and you are welcome to open an issue if you want to see something return as an optional feature.

## Contents

<!--toc:start-->

- [Features](#features)
- [Installation](#installation)
- [Plugins](#plugins)
- [Extras](#extras)
  - [Ghostty](#ghostty)
- [Configuration](#configuration)
  - [Lualine](#lualine)
  - [Trailblazer.nvim](#trailblazernvim)
  - [Render-markdown.nvim](#render-markdownnvim)
  - [Nvim-colorizer](#nvim-colorizer)
- [Acknowledgements](#acknowledgements)
- [Roadmap](#roadmap)
- [Unlicense](#unlicense)
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

Many plugins are already "supported" because they use standard Neovim highlight groups. However, some plugins require bespoke support. Additionally, some plugins may require extra setup to look good with Ashen. Please see [Configuration](#configuration) for more details.

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

## Extras

Extras can be found [here](./extras/).

### Ghostty

To use the Ashen theme in Ghostty, simply clone this repository and include the absolute path to the theme in your Ghostty config. For example:

```bash
git clone https://github.com/ficcdaf/ashen.nvim.git $home/ashen.nvim
echo 'theme = "$home/ashen.nvim/ghostty/ashen"' >> $home/.config/ghostty/config
```

### Kitty

To use the Ashen theme in Kitty, clone the repository, copy the theme into ~/.config/kitty/themes, then select the theme using the theme kitten. For example:

```bash
git clone https://github.com/ficcdaf/ashen.nvim.git $home/ashen.nvim
cp $home/ashen.nvim/kitty/Ashen.conf ~/.config/kitty/themes
kitten theme Ashen
```

## Configuration

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

### Nvim-colorizer

The following code snippet configures `nvim-colorizer` to use Ashen's palette when previewing certain named colors:

```Lua
return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  dependencies = {
    "ficcdaf/ashen.nvim",
  },
  opts = {
    user_default_options = {
      names = true,
      names_custom = function()
        return require("ashen.colors")
      end,
    },
  },
}
```

## Acknowledgements

Ashen was inspired by [nvim-noirbuddy](https://github.com/jesseleite/nvim-noirbuddy).

## Roadmap

- [ ] Override palette and arbitrary highlight groups.
- [ ] Specify any highlights to disable.
- [ ] Exclude any supported plugin modules from loading.
- [ ] Documentation for contributors to add plugin support.
- [ ] Compilation and caching of theme to improve startup time (like [kanagawa](https://github.com/rebelot/kanagawa.nvim))
- [ ] Kitty, Wezterm, Xresources, Pywal16 extras.

## Unlicense

Ashen is relinquished into the public domain. For more information, please see the [unlicense](./LICENSE).

## Contributing

I welcome contributions. If you want a certain plugin to be supported, please open and issue and I'll get to it as soon as I can. Please note that by contributing _code_ to this repository, you agree to [release it into the public domain.](./LICENSE).
