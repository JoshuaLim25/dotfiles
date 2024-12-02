-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins here ]]
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

  require 'essential/plugins/telescope',

  require 'essential/plugins/lspconfig',

  require 'essential/plugins/conform',

  require 'essential/plugins/cmp',

  -- WEIRD:
  -- require 'essential/plugins/colorschemes/color-scheme-kanagawa-paper',
  -- require 'essential/plugins/colorschemes/color-scheme-kanagawa-handmade.lua',

  require 'essential/plugins/colorschemes/color-scheme-kanagawa',

  -- CUSTOM
  -- require 'essential/plugins/colorschemes/color-scheme-handmade-hybrid',

  require 'essential/plugins/todo-comments',

  require 'essential/plugins/mini',

  require 'essential/plugins/treesitter',

  require 'essential.plugins.lint',

  require 'essential.plugins.autopairs',

  require 'essential.plugins.neo-tree',

  -- NOTE: to use these just uncomment them and
  -- mv the respective files from .bak to .lua

  -- require 'essential.plugins.indent_line',

  -- require 'essential.plugins.debug',

  require 'essential/plugins/which-key',

  -- modularize config
  { import = 'custom' },
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
