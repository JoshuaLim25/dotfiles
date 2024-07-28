return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    init = function()
      -- load the colorscheme here with custom settings.
      -- Default options:
      require('gruvbox').setup {
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = '', -- can be "hard", "soft" or empty string
        palette_overrides = {},
        -- palette_overrides = {
        --   bright_green = '#990000',
        -- },
        overrides = {},
        -- overrides = {
        --   SignColumn = {bg = "#ff9900"}
        -- },
        dim_inactive = false,
        transparent_mode = false,
      }
      vim.cmd 'colorscheme gruvbox'
    end,
  },
}
