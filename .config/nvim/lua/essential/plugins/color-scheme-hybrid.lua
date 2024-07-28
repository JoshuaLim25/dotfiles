return {
  {
    'HoNamDuong/hybrid.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    init = function()
      -- load the colorscheme here with custom settings.
      -- Default options:
      require('hybrid').setup {
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          emphasis = true,
          comments = true,
          folds = true,
        },
        strikethrough = true,
        inverse = true,
        transparent = false,
        overrides = function(hl, c)
          -- local background = '#1d1f21'
          local background = '#1d2021'
          hl.TelescopeNormal = {
            fg = c.fg,
            bg = background,
          }
          hl.TelescopeBorder = {
            fg = c.fg_hard,
            bg = c.bg,
          }
          hl.TelescopeTitle = {
            fg = c.fg_hard,
            bg = c.bg,
            bold = true,
          }
        end,
      }
      vim.cmd.colorscheme 'hybrid'
    end,
  },
}
