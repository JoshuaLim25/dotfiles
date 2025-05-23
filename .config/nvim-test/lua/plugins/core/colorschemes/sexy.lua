return {
  {
    -- sexy colors
    'rebelot/kanagawa.nvim',
    priority = 1000,
    init = function()
      require('kanagawa').setup {
        compile = false,
        undercurl = true,
        commentStyle = { italic = false },
        functionStyle = {},
        typeStyle = {},
        keywordStyle = { italic = false },
        statementStyle = { bold = true },
        operatorStyle = { bold = true },
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        colors = {
          palette = {
            waveRed = '#a54242',
            surimiOrange = '#de935f',
            roninYellow = '#f0c674',
            springGreen = '#b5bd68',
            waveAqua2 = '#87a987',
            springBlue = '#9fb5c9',
            crystalBlue = '#81a2be',
            oniViolet = '#b294bb',
            sakuraPink = '#c4746e',
            waveAqua1 = '#7AA89F',
            oldWhite = '#707880',
            fujiWhite = '#c5c8c6',
            sumiInk0 = '#1d1f21',
            sumiInk1 = '#1d1f21',
            sumiInk2 = '#1d1f21',
            sumiInk3 = '#1d1f21',
            sumiInk4 = '#282a2e',
            sumiInk5 = '#373b41',
            waveBlue1 = '#2D4F67',
            waveBlue2 = '#223249',
          },
          theme = {
            wave = {
              ui = {
                fg = '#c5c8c6',
                fg_dim = '#707880',
                fg_reverse = '#2D4F67',
                bg = '#1d1f21',
                bg_dim = '#1d1f21',
                bg_m3 = '#1d1f21',
                bg_m2 = '#1d1f21',
                bg_m1 = '#1d1f21',
                bg_p1 = '#282a2e',
                bg_p2 = '#373b41',
                bg_gutter = '#282a2e',
                special = '#81a2be',
                nontext = '#373b41',
                whitespace = '#373b41',
                bg_search = '#2D4F67',
                bg_visual = '#43436c',
                pmenu = {
                  fg = '#c5c8c6',
                  fg_sel = 'none',
                  bg = '#2D4F67',
                  bg_sel = '#223249',
                  bg_sbar = '#2D4F67',
                  bg_thumb = '#223249',
                },
                float = {
                  fg = '#707880',
                  bg = '#1d1f21',
                  fg_border = '#373b41',
                  bg_border = '#1d1f21',
                },
              },
              syn = {
                string = '#b5bd68',
                variable = 'none',
                number = '#c4746e',
                constant = '#de935f',
                identifier = '#f0c674',
                parameter = '#b5bd68',
                fun = '#81a2be',
                statement = '#b294bb',
                keyword = '#b294bb',
                operator = '#f0c674',
                preproc = '#a54242',
                type = '#87a987',
                regex = '#f0c674',
                deprecated = '#707880',
                comment = '#707880',
                punct = '#c5c8c6',
                special1 = '#9fb5c9',
                special2 = '#a54242',
                special3 = '#cc6666',
              },
              diag = {
                ok = '#b5bd68',
                error = '#cc6666',
                warning = '#f0c674',
                info = '#81a2be',
                hint = '#7AA89F',
              },
            },
            lotus = {},
            dragon = {},
            all = {},
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          local c = require 'kanagawa.lib.color'

          local tintDiagnosticBg = function(color)
            return {
              fg = color,
              bg = c(color):blend(theme.ui.bg, 0.95):to_hex(),
            }
          end

          return {
            Pmenu = { fg = theme.ui.fg, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
            PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            DiagnosticVirtualTextHint = tintDiagnosticBg(theme.diag.hint),
            DiagnosticVirtualTextInfo = tintDiagnosticBg(theme.diag.info),
            DiagnosticVirtualTextWarn = tintDiagnosticBg(theme.diag.warning),
            DiagnosticVirtualTextError = tintDiagnosticBg(theme.diag.error),

            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopeNormal = { bg = theme.ui.bg_dim },
            TelescopeBorder = { fg = theme.ui.bg_dim, bg = theme.ui.bg_dim },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { fg = theme.ui.bg_dim, bg = theme.ui.bg_dim },
            TelescopeResultsNormal = { bg = theme.ui.bg_dim },
            TelescopeResultsBorder = { fg = theme.ui.bg_dim, bg = theme.ui.bg_dim },

            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = 'none' },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            -- Markdown-specific
            ['@markup.link.url.markdown_inline'] = { link = 'Special' }, -- (url)
            ['@markup.link.label.markdown_inline'] = { link = 'WarningMsg' }, -- [label]
            ['@markup.italic.markdown_inline'] = { link = 'Exception' }, -- *italic*
            ['@markup.raw.markdown_inline'] = { link = 'String' }, -- `code`
            ['@markup.list.markdown'] = { link = 'Function' }, -- + list
            ['@markup.quote.markdown'] = { link = 'Error' }, -- > blockcode
            ['@markup.list.checked.markdown'] = { link = 'WarningMsg' }, -- - [X] checked list item
          }
        end,
        theme = 'wave',
        background = {
          dark = 'wave',
          light = 'lotus',
        },
      }

      vim.cmd 'colorscheme kanagawa'
    end,
  },
}
