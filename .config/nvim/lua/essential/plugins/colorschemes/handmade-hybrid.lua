return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    init = function()
      -- load the colorscheme here with custom settings.
      require('kanagawa').setup {
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentstyle = { italic = true },
        functionstyle = {},
        keywordstyle = { italic = true },
        statementstyle = { bold = true },
        typestyle = {},
        transparent = false, -- do not set background color
        diminactive = false, -- dim inactive window `:h hl-normalnc`
        terminalcolors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {
            -- colors here: https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/colors.lua
            -- usages here: https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/themes.lua
            -- tomorrow colors: https://github.com/chriskempson/vim-tomorrow-theme/blob/master/colors/Tomorrow-Night.vim
            --
            -- background
            -- gutter, `bg_gutter`
            -- dragonBlack4 = '#373b41', -- grayish
            dragonBlack4 = '#282a2e',

            -- "background", `bg`
            -- sumiInk3 = '#1d2021',
            dragonBlack3 = '#1d2021',

            -- purple, for `keyword`
            oniViolet = '#b294bb',
            dragonViolet = '#b294bb',
            -- golden yellow, for `operator`
            -- carpYellow = '#f0c674',
            boatYellow2 = '#f0c674',
            dragonRed = '#f0c674',
            -- brighter red, for macros
            waveRed = '#f2777a',
            -- green, for `string`
            springGreen = '#b5bd68',
            dragonGreen2 = '#b5bd68',
            -- light, muted blue, for `special-1` ?
            -- springBlue = '#8abeb7',
            -- (slightly) brighter light blue, for `type`
            waveAqua2 = '#8abeb7',
            dragonAqua = '#8abeb7',
            -- dark(er) blue, for `fun`
            -- this ones lighter
            -- crystalBlue = '#81a2be',
            -- this ones darker
            crystalBlue = '#7aa6da',
            dragonBlue2 = '#81a2be',
            -- golden yellow, just for yellow parameters :]
            oniViolet2 = '#f0c674',
            dragonGray = '#f0c674',
            --
            -- punct as white
            springViolet2 = '#DCD7BA',
            -- dragonGray2 = '#DCD7BA',
          },
          theme = {
            wave = {
              syn = {
                -- parameter = 'myYellow',
                -- type = 'yellow',
              },
            },
            dragon = {},
            lotus = {},
            all = {
              -- enable to remove "gutter" background, diff color
              -- ui = {
              --   bg_gutter = 'none',
              -- },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            -- Removes ugly borders
            normalfloat = { bg = 'none' },
            floatborder = { bg = 'none' },
            floattitle = { bg = 'none' },

            -- save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- e.g.: autocmd termopen * setlocal winhighlight=normal:normaldark
            normaldark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- popular plugins that open floats will link to normalfloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            lazynormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            masonnormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            pmenu = {
              fg = theme.ui.shade0,
              bg = theme.ui.bg_p1, --[[ blend = vim.o.pumblend ]]
            }, -- add `blend = vim.o.pumblend` to enable transparency
            pmenusel = { fg = 'none', bg = theme.ui.bg_p2 },
            pmenusbar = { bg = theme.ui.bg_m1 },
            pmenuthumb = { bg = theme.ui.bg_p2 },
          }
        end,
        theme = 'wave', -- load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
          dark = 'wave', -- try "dragon" !
          light = 'lotus',
        },
      }
      vim.cmd 'colorscheme kanagawa' -- this should match the theme set in the setup function.
    end,
  },
}
