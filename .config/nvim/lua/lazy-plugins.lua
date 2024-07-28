-- [[ Configure and install plugins ]]

require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --  This is equivalent to:
  --    require('Comment').setup({})

  { 'numToStr/Comment.nvim', opts = {} },

  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua

  require 'essential/plugins/gitsigns',

  require 'essential/plugins/which-key',

  require 'essential/plugins/telescope',

  require 'essential/plugins/lspconfig',

  require 'essential/plugins/conform',

  require 'essential/plugins/cmp',

  -- require 'essential/plugins/color-scheme-kanagawa-paper',
  -- require 'essential/plugins/color-scheme-kanagawa',
  require 'essential/plugins/color-scheme-handmade-hybrid',
  -- require 'essential/plugins/color-scheme-hybrid',
  -- require 'essential/plugins/color-scheme-hybrid2',
  -- require 'essential/plugins/color-scheme-gruvbox-dark-hard',

  require 'essential/plugins/todo-comments',

  require 'essential/plugins/mini',

  require 'essential/plugins/treesitter',

  require 'essential.plugins.indent_line',

  require 'essential.plugins.lint',

  require 'essential.plugins.autopairs',

  require 'essential.plugins.neo-tree',

  -- require 'essential.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
